using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Xsl;

namespace FLExAMXB
{
	class DictionaryProcessor : Processor
	{
		private string m_sXsltPassOne;
		private string m_sXsltPassTwo;

		public DictionaryProcessor() : base()
		{
			m_sXsltPassOne = Path.Combine(m_sAppDataPath, "FLExXHTML2MxbXHTML.xsl");
			m_sXsltPassTwo = Path.Combine(m_sAppDataPath, "FLExXHTML2MxbXHTML2.xsl");
			m_sSavedInfoFile = Path.Combine(m_sMyAppDataPath, "FLExAMXB.txt");
			GetAnySavedInfo();
		}

		public override void SetTransformsBasedOnConfiguredXHTMLFile()
		{
			bool fIsFLExConfiguredOutput = IsConfiguredXHTMLFileFLExConfiguredOutput();
			if (fIsFLExConfiguredOutput)
			{
				m_sXsltPassOne = Path.Combine(m_sAppDataPath, "FLExXHTML2MxbXHTML.xsl");
				m_sXsltPassTwo = Path.Combine(m_sAppDataPath, "FLExXHTML2MxbXHTML2.xsl");
			}
			else
			{
				m_sXsltPassOne = Path.Combine(m_sAppDataPath, "FLEx7-8.2XHTML2MxbXHTML.xsl");
				m_sXsltPassTwo = Path.Combine(m_sAppDataPath, "FLEx7-8.2XHTML2MxbXHTML2.xsl");
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
		
		protected override void ReadSavedInfo()
		{
			var reader = File.OpenText(m_sSavedInfoFile);
			OutputPdf = Convert.ToBoolean(reader.ReadLine());      // line 1 is pdf output
			OutputWebPage = Convert.ToBoolean(reader.ReadLine());  // line 2 is web page output
			Header = reader.ReadLine();                            // line 3 is the header
			string sFooterOption = reader.ReadLine();              // line 4 is the footer option
			CustomFooter = reader.ReadLine();                      // line 5 is the custom footer
			string sPageSize = reader.ReadLine();                  // line 6 is the page size
			//No; it could be confusing to mix dictionary and reversal files:
			//ConfiguredXhtmlFilePath = reader.ReadLine();           // line 7 is the exported file
			FLExPicturesFilePath = reader.ReadLine();              // line 7 is the FLEx project path 
			reader.Close();
			SetFooterKind(sFooterOption);
			SetPageSizeKind(sPageSize);
			StartPageNumber = 1;
		}
		protected override void WriteSavedInfo()
		{
			var writer = File.CreateText(m_sSavedInfoFile);
			writer.WriteLine(OutputPdf);               // line 1 is pdf output
			writer.WriteLine(OutputWebPage);           // line 2 is web page output
			writer.WriteLine(Header);			       // line 3 is the header
			writer.WriteLine(Footer.ToString());       // line 4 is the footer
			writer.WriteLine(CustomFooter);		       // line 5 is the custom footer
			writer.WriteLine(PageSize.ToString());     // line 6 is the page size
			//No; it could be confusing to mix dictionary and reversal files:
			//writer.WriteLine(ConfiguredXhtmlFilePath); // line 7 is the exported file
			writer.WriteLine(FLExPicturesFilePath);    // line 7 is the FLEx project path 
			writer.Close();
		}

		protected override void CreateCssFilePerPageSize(String sCssTypeBase)
		{
			base.CreateCssFilePerPageSize("Dictionary MXB XHTML");
		}
	}
}
