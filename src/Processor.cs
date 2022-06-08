using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Xsl;

namespace FLExAMXB
{
	class Processor
	{
		protected bool m_fOutputPDF;
		protected bool m_fOutputWebPage;
		private FooterKind m_Footer;
		private PageSizeKind m_PageSize;
		private string m_sHeader;
		protected string m_sConfiguredXHTMLFilePath;
		public string FLExPicturesFilePath { get; set; }
		protected string m_sCss;
		private string m_sCustomFooter;
		private int m_iStartPageNumber = 1;
		protected string m_sAppDataPath;
		protected const string m_ksProcessedFileEnding = "MXB.xhtml";
		protected string m_sMyAppDataPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), Path.Combine("SIL", "MXB-FLEx"));
		protected string m_sSavedInfoFile;

		public enum FooterKind
		{
			Nothing,
			Draft,
			Custom
		}
		public enum PageSizeKind
		{
			ps6x9,
			ps6x85,
			ps66x85,
			ps85x11
		}

		public Processor()
		{
			m_sAppDataPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), Path.Combine("SIL", "MXB-FLEx"));
			m_sCss = "file://" + m_sAppDataPath + "\\";
			m_Footer = FooterKind.Draft;
		}

		public void SetState(Processor processor)
		{
			if (processor != null)
			{
				m_sConfiguredXHTMLFilePath = processor.m_sConfiguredXHTMLFilePath;
				m_sCss = processor.m_sCss;
			}
		}

		public void ProcessFile(ProgressBar progressBar)
		{
			string sMxbXHtmlFile = GetOutputName(m_ksProcessedFileEnding);
			CreateCssFilePerPageSize(null);
			SetStartPageNumber();
			ApplyTransforms(sMxbXHtmlFile, progressBar);
			if (m_fOutputPDF)
			{
				CreatePDF(sMxbXHtmlFile, progressBar);
				if (!m_fOutputWebPage)
					File.Delete(sMxbXHtmlFile);
			}
		}

		protected void GetAnySavedInfo()
		{
			if (File.Exists(m_sSavedInfoFile))
			{
				ReadSavedInfo();
			}
		}
		
		public void RememberSavedInfo()
		{
			if (!File.Exists(m_sSavedInfoFile))
			{
				Directory.CreateDirectory(Path.GetDirectoryName(m_sSavedInfoFile));
			}
			WriteSavedInfo();
		}

		protected virtual void ReadSavedInfo()
		{
			throw new NotImplementedException();
		}
		
		protected virtual void WriteSavedInfo()
		{
			throw new NotImplementedException();
		}
		
		protected void SetFooterKind(string sFooterOption)
		{
			FooterKind kind = FooterKind.Draft;
			switch (sFooterOption)
			{
				case "Nothing":
					kind = FooterKind.Nothing;
					break;
				case "Draft":
					kind = FooterKind.Draft;
					break;
				case "Custom":
					kind = FooterKind.Custom;
					break;
			}
			Footer = kind;
		}

		protected void SetPageSizeKind(string sPageSizeOption)
		{
			PageSizeKind kind = PageSizeKind.ps85x11;
			switch (sPageSizeOption)
			{
				case "ps6x85":
					kind = PageSizeKind.ps6x85;
					break;
				case "ps6x9":
					kind = PageSizeKind.ps6x9;
					break;
				case "ps66x85":
					kind = PageSizeKind.ps66x85;
					break;
				default:
					kind = PageSizeKind.ps85x11;
					break;
			}
			PageSize = kind;
		}
		
		protected virtual void ApplyTransforms(string sOutputName, ProgressBar progressBar)
		{
			throw new NotImplementedException();
		}

		protected virtual void CreateCssFilePerPageSize(String sCssTypeBase)
		{
			string sBaseCssFileName = m_sCss.Substring(7) + sCssTypeBase + "NoPageSizeInfo.css";
			string sTemp;
			if (this.PageSize == PageSizeKind.ps6x85)
			{
				sTemp = "-6x8.5.css";
			}
			else if (this.PageSize == PageSizeKind.ps6x9)
			{
				sTemp = "-6x9.css";
			}
			else if (this.PageSize == PageSizeKind.ps66x85)
			{
				sTemp = "-6.6x8.5.css";
			}
 			else
			{
				sTemp = "-8.5x11.css";
			}
			string sPageSizeCssFile = m_sCss.Substring(7) + sCssTypeBase + sTemp;
			string sCssFileToUse = m_sCss.Substring(7) + sCssTypeBase + ".css";

			if (File.Exists(sCssFileToUse))
			{
				File.Delete(sCssFileToUse);
			}
			// read base file and then append page size file
			var reader = File.OpenText(sBaseCssFileName);
			string sBaseCssContent = reader.ReadToEnd();
			reader.Close();
			File.WriteAllText(sCssFileToUse, sBaseCssContent);
			reader = File.OpenText(sPageSizeCssFile);
			string sPageSizeCssContent = reader.ReadToEnd();
			reader.Close();
			File.AppendAllText(sCssFileToUse, sPageSizeCssContent);
		}

		protected virtual void SetStartPageNumber()
		{
			; // default is to do nothing
		}

		protected void AddParameters(out XsltArgumentList args, XSLParameter[] parameterList)
		{
			args = new XsltArgumentList();
			if (parameterList != null)
			{
				foreach (XSLParameter rParam in parameterList)
				{
					// Following is a specially recognized parameter name
					if (rParam.Name == "prmSDateTime")
					{
						args.AddParam(rParam.Name, "", GetCurrentDateTime());
					}
					else
						args.AddParam(rParam.Name, "", rParam.Value);
				}
			}
		}

		protected void CreatePDF(string sInputName, ProgressBar progressBar)
		{
			// instantiate Prince by specifying the full path to the engine executable
			string sPrince = "C:\\Program Files\\Prince\\Engine\\bin\\prince.exe";
			if (!File.Exists(sPrince))
			{
				sPrince = "C:\\Program Files (x86)\\Prince\\Engine\\bin\\prince.exe";
			}
			if (!File.Exists(sPrince))
			{
				MessageBox.Show(
					"Lo siento,pero el progama 'Prince' no se encuento.\nFavor de obtenir el programa del http://www.princexml.com/.",
					"Noticia", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				return;
			}
			Prince prn = new Prince(sPrince);

			// specify the log file for error and warning messages
			// make sure that you have write permissions for this file
			string sMyAppData = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), Path.Combine("SIL", "MXB-FLEx"));
			string sLogFile = Path.Combine(sMyAppData, Path.GetFileNameWithoutExtension(sInputName) + ".log");
			if (!File.Exists(sLogFile))
			{
				Directory.CreateDirectory(Path.GetDirectoryName(sMyAppData));
			}
			else
				File.Delete(sLogFile);
			prn.SetLog(sLogFile);

			// convert a HTML document into a PDF file
			string sPDFFile = GetPDFFileName();
			prn.Convert(sInputName, sPDFFile);
			progressBar.PerformStep();
		}

		private static string GetCurrentDateTime()
		{
			DateTime now;
			now = DateTime.Now;

			CultureInfo ci = Thread.CurrentThread.CurrentCulture;
			Thread.CurrentThread.CurrentCulture = new CultureInfo("es-MX", false);

			string sTime = now.ToLongTimeString().Replace("a.m.", "AM").Replace("p.m.", "PM");
			string sResult = (now.ToLongDateString() + ", " + sTime);

			Thread.CurrentThread.CurrentCulture = ci;

			return sResult;
		}


		protected void SetParameters(XSLParameter[] parameterList)
		{
			parameterList[0] = new XSLParameter("sCSSDir", m_sCss);
			parameterList[1] = new XSLParameter("sTitle", string.IsNullOrEmpty(m_sHeader) ? "" : m_sHeader);
			string sFooter;
			if (m_Footer == Processor.FooterKind.Draft)
			{
				sFooter = "Borrador (" + GetCurrentDateTime() + ")";
			}
			else if (m_Footer == Processor.FooterKind.Custom)
			{
				sFooter = m_sCustomFooter;
			}
			else
			{
				sFooter = "";
			}
			parameterList[2] = new XSLParameter("sBorradorFecha", sFooter);
			string sLinkedFilesPath = FLExPicturesFilePath;
			if (string.IsNullOrEmpty(sLinkedFilesPath))
			{
				sLinkedFilesPath = "";
			}
			else
			{
				sLinkedFilesPath = FLExPicturesFilePath.Replace("\\", "/");
			}
			parameterList[3] = new XSLParameter("sLinkedFilesPath", sLinkedFilesPath);
		}

		protected void TransformFiles(XslCompiledTransform transformer, XsltArgumentList args, string sInputFile,
									string sOutputFile)
		{
			using (var writer = File.CreateText(sOutputFile))
			{
				// load input file
				using (var reader = new XmlTextReader(sInputFile))
				{
#if !__MonoCS__
					reader.DtdProcessing = DtdProcessing.Ignore;
#else
					reader.ProhibitDtd = false;
#endif
					reader.EntityHandling = EntityHandling.ExpandEntities;

					// Apply transform
					transformer.Transform(reader, args, writer);
				}
			}

		}

		protected string GetOutputName(string sAddition)
		{
			string sOutputName1 = Path.GetFileNameWithoutExtension(m_sConfiguredXHTMLFilePath) + sAddition;
			return Path.Combine(Path.GetDirectoryName(m_sConfiguredXHTMLFilePath), sOutputName1);
		}

		public virtual void SetTransformsBasedOnConfiguredXHTMLFile()
		{
			; // default is to do nothing
		}
		public bool IsConfiguredXHTMLFileFLExConfiguredOutput()
		{
			bool fIsFLExConfiguredOutput = true;
			using (TextReader reader = File.OpenText(m_sConfiguredXHTMLFilePath))
			{
				string content = reader.ReadToEnd();
				reader.Close();
				int index = content.IndexOf(" id=");
				if (index >= 0)
				{
					string sId = content.Substring(index+5, 15);
					if (sId.StartsWith("hvo"))
					{
						fIsFLExConfiguredOutput = false;
					}
				}
			}
			return fIsFLExConfiguredOutput;
		}

		public bool PDFFileIsDeleted()
		{
			try
			{
				string sPDFFile = GetPDFFileName();
				if (File.Exists(sPDFFile))
				{
					File.Delete(sPDFFile);
				}
				return true;
			}
			catch (IOException e)
			{  // it is probably being held by a PDF Viewer
				string sMsg = e.Message;
				return false;
			}
		}
		
		public string GetPDFFileName()
		{
			string sPDFFile = GetOutputName(m_ksProcessedFileEnding);
			return Path.Combine(Path.GetDirectoryName(sPDFFile), Path.GetFileNameWithoutExtension(sPDFFile) + ".pdf");
		}
		public bool OutputPdf
		{
			get { return m_fOutputPDF; }
			set { m_fOutputPDF = value; }
		}

		public bool OutputWebPage
		{
			get { return m_fOutputWebPage; }
			set { m_fOutputWebPage = value; }
		}

		public string Header
		{
			get { return m_sHeader; }
			set { m_sHeader = value; }
		}

		public string ConfiguredXhtmlFilePath
		{
			get { return m_sConfiguredXHTMLFilePath; }
			set { m_sConfiguredXHTMLFilePath = value; }
		}

		public FooterKind Footer
		{
			get { return m_Footer; }
			set { m_Footer = value; }
		}

		public string CustomFooter
		{
			get { return m_sCustomFooter; }
			set { m_sCustomFooter = value; }
		}

		public PageSizeKind PageSize
		{
			get { return m_PageSize; }
			set { m_PageSize = value; }
		}

		public int StartPageNumber
		{
			get { return m_iStartPageNumber; }
			set { m_iStartPageNumber = value; }
		}
	}
	public class XSLParameter
	{
		/// <summary>
		/// Parameter name.
		/// </summary>
		private string m_name;

		/// <summary>
		/// Parameter value.
		/// </summary>
		private string m_value;

		public XSLParameter(string sName, string sValue)
		{
			m_name = sName;
			m_value = sValue;
		}

		public string Name
		{
			get { return m_name; }
			set { m_name = value; }
		}

		public string Value
		{
			get { return m_value; }
			set { m_value = value; }
		}
	}
}
