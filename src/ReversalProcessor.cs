using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Xml.Xsl;

namespace FLExAMXB
{
	internal class ReversalProcessor : Processor
	{
		/*private string m_sXslt;*/
		private string m_sXsltPassOne;
		private string m_sXsltPassTwo;

		public ReversalProcessor()
			: base()
		{
			m_sXsltPassOne = Path.Combine(m_sAppDataPath, "FLExXHTML2MxbReversalXHTML.xsl");
			m_sXsltPassTwo = Path.Combine(m_sAppDataPath, "FLExXHTML2MxbReversalXHTML2.xsl");

			m_sSavedInfoFile = Path.Combine(m_sMyAppDataPath, "FLExAMXBReversal.txt");
			GetAnySavedInfo();
		}

		public override void SetTransformsBasedOnConfiguredXHTMLFile()
		{
			bool fIsFLExConfiguredOutput = IsConfiguredXHTMLFileFLExConfiguredOutput();
			if (fIsFLExConfiguredOutput)
			{
				m_sXsltPassOne = Path.Combine(m_sAppDataPath, "FLExXHTML2MxbReversalXHTML.xsl");
				m_sXsltPassTwo = Path.Combine(m_sAppDataPath, "FLExXHTML2MxbReversalXHTML2.xsl");
			}
			else
			{
				m_sXsltPassOne = Path.Combine(m_sAppDataPath, "FLEx7-8.2XHTML2MxbReversalXHTML.xsl");
				m_sXsltPassTwo = Path.Combine(m_sAppDataPath, "FLEx7-8.2XHTML2MxbReversalXHTML2.xsl");
			}
		}


		protected override void ApplyTransforms(string sOutputName, ProgressBar progressBar)
		{
			// set up transform
			XslCompiledTransform transformer = new XslCompiledTransform();
			transformer.Load(m_sXsltPassOne);

			// add any parameters
			XSLParameter[] parameterList;
			parameterList = new XSLParameter[4];
			SetParameters(parameterList);
			XsltArgumentList args;
			AddParameters(out args, parameterList);

			// setup first output file
			string sOutputTemp = GetOutputName("MXBTemp.xhtml");

			// Do transform
			TransformFiles(transformer, args, m_sConfiguredXHTMLFilePath, sOutputTemp);
			progressBar.PerformStep();

			// set up transform
			XslCompiledTransform transformer2 = new XslCompiledTransform();
			transformer2.Load(m_sXsltPassTwo);
			args = null;

			//Do transform
			TransformFiles(transformer2, args, sOutputTemp, sOutputName);
			progressBar.PerformStep();

			// No longer need the temp file
			File.Delete(sOutputTemp);
		}

		protected override void CreateCssFilePerPageSize(string sCssTypeBase)
		{
			base.CreateCssFilePerPageSize("FLExXHTML2MxbReversalXHTML");
		}

		protected override void SetStartPageNumber()
		{
			// we need to find the line in the CSS file that controls the starting page number and change it
			string sCssFileNameBase = m_sCss.Substring(7) + "FLExXHTML2MxbReversalXHTML";
			string sCssFileOld = sCssFileNameBase + ".css";
			string sCssFileNew = sCssFileNameBase + "New.css";
			var reader = File.OpenText(sCssFileOld);
			var writer = File.CreateText(sCssFileNew);
			// look for the important body line
			string sCssLine = reader.ReadLine();
			while (sCssLine != "body {")
			{
				writer.WriteLine(sCssLine);
				sCssLine = reader.ReadLine();
			}
			// there are then six lines after the body line
			for (int i = 0; i < 7; i++)
			{
				writer.WriteLine(sCssLine);
				sCssLine = reader.ReadLine();
			}
			// Now we have the crucial counter-reset line; set the current starting page number
			writer.WriteLine("    counter-reset: page " + StartPageNumber + ";");
			// read the rest of the file and write it
			sCssLine = reader.ReadToEnd();
			writer.Write(sCssLine);
			reader.Close();
			writer.Close();
			File.Copy(sCssFileNew, sCssFileOld, true);
			File.Delete(sCssFileNew);
		}

		protected override void ReadSavedInfo()
		{
			var reader = File.OpenText(m_sSavedInfoFile);
			OutputPdf = Convert.ToBoolean(reader.ReadLine());      // line 1 is pdf output
			OutputWebPage = Convert.ToBoolean(reader.ReadLine());  // line 2 is web page output
			Header = reader.ReadLine();                            // line 3 is the header
			string sFooterOption = reader.ReadLine();              // line 4 is the footer option
			CustomFooter = reader.ReadLine();                      // line 5 is the custom footer
			try
			{
				StartPageNumber = Convert.ToInt32(reader.ReadLine()); // line 6 is the starting page number
			}
			catch (FormatException)
			{
				StartPageNumber = 1;
			}
			string sPageSize = reader.ReadLine();                  // line 7 is the page size
			//No; it could be confusing to mix dictionary and reversal files:
			//ConfiguredXhtmlFilePath = reader.ReadLine();           // line 8 is the exported file
			reader.Close();
			SetFooterKind(sFooterOption);
			SetPageSizeKind(sPageSize);
		}
		protected override void WriteSavedInfo()
		{
			var writer = File.CreateText(m_sSavedInfoFile);
			writer.WriteLine(OutputPdf);               // line 1 is pdf output
			writer.WriteLine(OutputWebPage);           // line 2 is web page output
			writer.WriteLine(Header);			       // line 3 is the header
			writer.WriteLine(Footer.ToString());       // line 4 is the footer
			writer.WriteLine(CustomFooter);		       // line 5 is the custom footer
			writer.WriteLine(StartPageNumber);         // line 6 is the starting page number
			writer.WriteLine(PageSize.ToString());     // line 7 is the page size
			//No; it could be confusing to mix dictionary and reversal files:
			//writer.WriteLine(ConfiguredXhtmlFilePath); // line 8 is the exported file
			writer.Close();
		}

	}
}
