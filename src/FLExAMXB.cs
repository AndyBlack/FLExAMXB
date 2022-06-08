using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace FLExAMXB
{
	public partial class FLExAMXB : Form
	{
		private Processor m_processor;
		string m_sMyAppDataPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), Path.Combine("SIL", "MXB-FLEx"));
		private string m_sLastPartUsed;
		private const string m_ksDictionary = "Dictionary";
		private const string m_ksReversal = "Reversal";
		private string m_FLExProjectsLocation = Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData) +
							   @"\SIL\Fieldworks\Projects";
		
		public FLExAMXB()
		{
			InitializeComponent();
			m_processor = GetProcessorToUse();
			FillFLExProjectsComboBox();
			ShowAnySavedInfo();
			EnableDisableItems();
		}

		void FillFLExProjectsComboBox()
		{
			string[] asProjects = Directory.GetDirectories(m_FLExProjectsLocation);
			m_comboBoxFLExProjects.Items.Clear();
			foreach (var sProject in asProjects)
			{
				m_comboBoxFLExProjects.Items.Add(Path.GetFileName(sProject));
			}
		}

		Processor GetProcessorToUse()
		{
			m_sLastPartUsed = Path.Combine(m_sMyAppDataPath, "FLExAMXBLastPartUsed.txt");
			if (File.Exists(m_sLastPartUsed))
			{
				var reader = File.OpenText(m_sLastPartUsed);
				string sPart = reader.ReadLine();
				reader.Close();
				if (sPart == m_ksDictionary)
				{
					return new DictionaryProcessor();
				}
				else
				{
					m_radioButtonReversal.Checked = true;
					return new ReversalProcessor();
				}
				
			}
				return new DictionaryProcessor();			
		}

		void ShowAnySavedInfo()
		{
			m_checkBoxPDF.Checked = m_processor.OutputPdf;
			m_checkBoxWebPage.Checked = m_processor.OutputWebPage;
			m_textBoxHeader.Text = m_processor.Header;
			switch (m_processor.Footer)
			{
					case Processor.FooterKind.Nothing:
					m_radioButtonNothing.Checked = true;
					break;
					case Processor.FooterKind.Draft:
					m_radioButtonDraft.Checked = true;
					break;
					case Processor.FooterKind.Custom:
					m_radioButtonCustom.Checked = true;
					break;
			}
			switch (m_processor.PageSize)
			{
				case Processor.PageSizeKind.ps6x85:
					m_radioButton6By85.Checked = true;
					break;
				case Processor.PageSizeKind.ps6x9:
					m_radioButton6By9.Checked = true;
					break;
				case Processor.PageSizeKind.ps66x85:
					m_radioButton66By85.Checked = true;
					break;
				default:
					m_radioButton85By11.Checked = true;
					break;
			}
			m_textBoxCustom.Text = m_processor.CustomFooter;
			m_numericUpDownStartPageNumber.Value = m_processor.StartPageNumber;
			//No; it could be confusing to mix dictionary and reversal files:
			//m_textBoxFileName.Text = m_processor.ConfiguredXhtmlFilePath;
			string sProjectName = "";
			string sProjectPath = m_processor.FLExPicturesFilePath;
			if (!string.IsNullOrEmpty(sProjectPath))
			{
				string[] asPaths = sProjectPath.Split('\\');
				if (asPaths.Length == 7)
				{
					sProjectName = asPaths[5];
				}
			}
			m_comboBoxFLExProjects.Text = sProjectName;
		}

		private void m_buttonBrowse_Click(object sender, EventArgs e)
		{
			FileDialog dlg = new OpenFileDialog();
			dlg.InitialDirectory = m_textBoxFileName.Text;
			dlg.SupportMultiDottedExtensions = true;
			dlg.Filter = "XHTML files (*.xhtml)|*.xhtml|All files (*.*)|*.*";
			dlg.FilterIndex = 1;
			dlg.RestoreDirectory = true;
			var result = dlg.ShowDialog();
			if (result == DialogResult.OK)
			{
				m_textBoxFileName.Text = dlg.FileName;
			}
			m_processor.ConfiguredXhtmlFilePath = m_textBoxFileName.Text;
			EnableDisableItems();
		}

		private void m_checkBoxPDF_CheckedChanged(object sender, EventArgs e)
		{
			m_processor.OutputPdf = m_checkBoxPDF.Checked;
			EnableDisableItems();
		}

		private void m_checkBoxWebPage_CheckedChanged(object sender, EventArgs e)
		{
			m_processor.OutputWebPage = m_checkBoxWebPage.Checked;
			EnableDisableItems();
		}

		private void m_textBoxHeader_TextChanged(object sender, EventArgs e)
		{
			m_processor.Header = m_textBoxHeader.Text;
		}
		private void m_buttonOK_Click(object sender, EventArgs e)
		{
			var currentCursor = Cursor.Current;
			Cursor.Current = Cursors.WaitCursor;
			InitProgressBar();
			m_processor.SetTransformsBasedOnConfiguredXHTMLFile();
			if (m_checkBoxPDF.Checked)
			{
				while (!m_processor.PDFFileIsDeleted())
				{
					string sPDFFile = m_processor.GetPDFFileName();
					var result = MessageBox.Show("Favor de cerrar el archivo '" + sPDFFile + "' del programa de PDF.", "¡Advertencia!", MessageBoxButtons.OKCancel,
					                MessageBoxIcon.Exclamation);
					if (result == DialogResult.Cancel)
						return;
				}
			}
			m_processor.ProcessFile(m_progressBar);
			Cursor.Current = currentCursor;
			MessageBox.Show("Formateo completo", "Proceso de formatear", MessageBoxButtons.OK, MessageBoxIcon.Information);
			//Close();
		}

		private void InitProgressBar()
		{
			m_progressBar.Visible = true;
			m_progressBar.Minimum = 1;
			if (m_radioButtonDictionary.Checked)
			{
				m_progressBar.Maximum = m_processor.OutputPdf ? 4 : 3;
			}
			else
			{
				m_progressBar.Maximum = m_processor.OutputPdf ? 4 : 3; // now both have two passes
			}
			m_progressBar.Value = 1;
			m_progressBar.Step = 1;
		}

		private void m_buttonCancel_Click(object sender, EventArgs e)
		{
			Close();
		}
		protected override void OnClosing(CancelEventArgs e)
		{
			RememberLastPartUsed();
			m_processor.StartPageNumber = (int) m_numericUpDownStartPageNumber.Value;
			m_processor.RememberSavedInfo();
			base.OnClosing(e);
		}

		private void RememberLastPartUsed()
		{
			if (!File.Exists(m_sLastPartUsed))
			{
				Directory.CreateDirectory(Path.GetDirectoryName(m_sLastPartUsed));
			}
			var writer = File.CreateText(m_sLastPartUsed);
			if (m_radioButtonDictionary.Checked)
			{
				writer.WriteLine(m_ksDictionary);
			}
			else
			{
				writer.WriteLine(m_ksReversal);
			}
			writer.Close();
		}

		void EnableDisableItems()
		{
			if (m_checkBoxPDF.Checked)
			{
				m_groupBoxPageSize.Enabled = true;
				m_groupBoxFooter.Enabled = true;
				if (m_radioButtonCustom.Checked)
					m_textBoxCustom.Enabled = true;
				else
					m_textBoxCustom.Enabled = false;
				m_buttonOK.Enabled = true;
			}
			else
			{
				m_groupBoxPageSize.Enabled = false;
				m_groupBoxFooter.Enabled = false;
				if (m_checkBoxWebPage.Checked)
				{
					m_buttonOK.Enabled = true;
				}
				else
				{
					m_buttonOK.Enabled = false;
				}
			}
			if (m_radioButtonDictionary.Checked)
			{
				m_labelStartPageNumber.Enabled = false;
				m_numericUpDownStartPageNumber.Enabled = false;
			}
			else
			{
				m_labelStartPageNumber.Enabled = true;
				m_numericUpDownStartPageNumber.Enabled = true;
			}
			if (string.IsNullOrEmpty(m_textBoxFileName.Text))
			{
				m_buttonOK.Enabled = false;
				m_comboBoxFLExProjects.Enabled = false;
			}
			else
			{
				if (m_processor != null)
				{
					m_processor.ConfiguredXhtmlFilePath = m_textBoxFileName.Text;
					if (m_processor.IsConfiguredXHTMLFileFLExConfiguredOutput())
					{
						m_comboBoxFLExProjects.Enabled = true;
					}
					else
					{
						m_comboBoxFLExProjects.Enabled = false;
					}
				}
			}
			if (m_processor != null && m_processor is ReversalProcessor)
			{
				m_comboBoxFLExProjects.Enabled = false;
			}
			if (m_comboBoxFLExProjects.Enabled)
			{
				string sSelection = m_comboBoxFLExProjects.SelectedItem as string;
				if (string.IsNullOrEmpty(sSelection))
				{
					m_buttonOK.Enabled = false;
				}
				else
				{
					m_buttonOK.Enabled = true;
				}
			}
		}

		private void m_radioButtonCustom_CheckedChanged(object sender, EventArgs e)
		{
			EnableDisableItems();
			if (m_radioButtonCustom.Checked)
				m_processor.Footer = Processor.FooterKind.Custom;
		}

		private void m_radioButtonNothing_CheckedChanged(object sender, EventArgs e)
		{
			EnableDisableItems();
			if (m_radioButtonNothing.Checked)
				m_processor.Footer = Processor.FooterKind.Nothing;
		}

		private void m_radioButtonDraft_CheckedChanged(object sender, EventArgs e)
		{
			EnableDisableItems();
			if (m_radioButtonDraft.Checked)
				m_processor.Footer = Processor.FooterKind.Draft;
		}

		private void m_textBoxCustom_TextChanged(object sender, EventArgs e)
		{
			m_processor.CustomFooter = m_textBoxCustom.Text;
		}

		private void m_radioButtonReversal_CheckedChanged(object sender, EventArgs e)
		{
			if (m_radioButtonReversal.Checked)
			{
				var reversalProcessor = new ReversalProcessor();
				reversalProcessor.SetState(m_processor);
				m_processor = reversalProcessor;
			}
			else
			{
				var dictionaryProcessor = new DictionaryProcessor();
				dictionaryProcessor.SetState(m_processor);
				m_processor = dictionaryProcessor;
			}
			ShowAnySavedInfo();
			EnableDisableItems();
		}

		private void m_numericUpDownStartPageNumber_ValueChanged(object sender, EventArgs e)
		{
			m_processor.StartPageNumber = (int)m_numericUpDownStartPageNumber.Value;
		}

		private void m_radioButton6By85_CheckedChanged(object sender, EventArgs e)
		{
			EnableDisableItems();
			if (m_radioButton6By85.Checked)
				m_processor.PageSize = Processor.PageSizeKind.ps6x85;
		}

		private void m_radioButton6By9_CheckedChanged(object sender, EventArgs e)
		{
			EnableDisableItems();
			if (m_radioButton6By9.Checked)
				m_processor.PageSize = Processor.PageSizeKind.ps6x9;
		}

		private void m_radioButton66By85_CheckedChanged(object sender, EventArgs e)
		{
			EnableDisableItems();
			if (m_radioButton66By85.Checked)
				m_processor.PageSize = Processor.PageSizeKind.ps66x85;
		}

		private void m_radioButton85By11_CheckedChanged(object sender, EventArgs e)
		{
			EnableDisableItems();
			if (m_radioButton85By11.Checked)
				m_processor.PageSize = Processor.PageSizeKind.ps85x11;
		}

		private void m_comboBoxFLExProjects_SelectedIndexChanged(object sender, EventArgs e)
		{
			m_processor.FLExPicturesFilePath = m_FLExProjectsLocation + Path.DirectorySeparatorChar +
				m_comboBoxFLExProjects.SelectedItem + Path.DirectorySeparatorChar + "LinkedFiles";
			EnableDisableItems();
		}
	}
}
