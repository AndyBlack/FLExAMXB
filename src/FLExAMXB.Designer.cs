namespace FLExAMXB
{
	partial class FLExAMXB
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FLExAMXB));
			this.m_buttonOK = new System.Windows.Forms.Button();
			this.m_buttonCancel = new System.Windows.Forms.Button();
			this.m_labelFileName = new System.Windows.Forms.Label();
			this.m_textBoxFileName = new System.Windows.Forms.TextBox();
			this.m_buttonBrowse = new System.Windows.Forms.Button();
			this.m_groupBoxContent = new System.Windows.Forms.GroupBox();
			this.m_numericUpDownStartPageNumber = new System.Windows.Forms.NumericUpDown();
			this.m_labelStartPageNumber = new System.Windows.Forms.Label();
			this.m_groupBoxFooter = new System.Windows.Forms.GroupBox();
			this.m_textBoxCustom = new System.Windows.Forms.TextBox();
			this.m_radioButtonCustom = new System.Windows.Forms.RadioButton();
			this.m_radioButtonDraft = new System.Windows.Forms.RadioButton();
			this.m_radioButtonNothing = new System.Windows.Forms.RadioButton();
			this.m_textBoxHeader = new System.Windows.Forms.TextBox();
			this.m_labelHeader = new System.Windows.Forms.Label();
			this.m_groupBoxOutput = new System.Windows.Forms.GroupBox();
			this.m_groupBoxPageSize = new System.Windows.Forms.GroupBox();
			this.m_radioButton6By85 = new System.Windows.Forms.RadioButton();
			this.m_radioButton66By85 = new System.Windows.Forms.RadioButton();
			this.m_radioButton85By11 = new System.Windows.Forms.RadioButton();
			this.m_radioButton6By9 = new System.Windows.Forms.RadioButton();
			this.m_checkBoxWebPage = new System.Windows.Forms.CheckBox();
			this.m_checkBoxPDF = new System.Windows.Forms.CheckBox();
			this.m_progressBar = new System.Windows.Forms.ProgressBar();
			this.m_groupBoxResult = new System.Windows.Forms.GroupBox();
			this.m_radioButtonReversal = new System.Windows.Forms.RadioButton();
			this.m_radioButtonDictionary = new System.Windows.Forms.RadioButton();
			this.m_labelProjectLocation = new System.Windows.Forms.Label();
			this.m_comboBoxFLExProjects = new System.Windows.Forms.ComboBox();
			this.m_groupBoxContent.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.m_numericUpDownStartPageNumber)).BeginInit();
			this.m_groupBoxFooter.SuspendLayout();
			this.m_groupBoxOutput.SuspendLayout();
			this.m_groupBoxPageSize.SuspendLayout();
			this.m_groupBoxResult.SuspendLayout();
			this.SuspendLayout();
			// 
			// m_buttonOK
			// 
			this.m_buttonOK.DialogResult = System.Windows.Forms.DialogResult.OK;
			this.m_buttonOK.Location = new System.Drawing.Point(546, 955);
			this.m_buttonOK.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_buttonOK.Name = "m_buttonOK";
			this.m_buttonOK.Size = new System.Drawing.Size(126, 43);
			this.m_buttonOK.TabIndex = 5;
			this.m_buttonOK.Text = "Formatear";
			this.m_buttonOK.UseVisualStyleBackColor = true;
			this.m_buttonOK.Click += new System.EventHandler(this.m_buttonOK_Click);
			// 
			// m_buttonCancel
			// 
			this.m_buttonCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.m_buttonCancel.Location = new System.Drawing.Point(698, 952);
			this.m_buttonCancel.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_buttonCancel.Name = "m_buttonCancel";
			this.m_buttonCancel.Size = new System.Drawing.Size(150, 45);
			this.m_buttonCancel.TabIndex = 6;
			this.m_buttonCancel.Text = "Cancelar";
			this.m_buttonCancel.UseVisualStyleBackColor = true;
			this.m_buttonCancel.Click += new System.EventHandler(this.m_buttonCancel_Click);
			// 
			// m_labelFileName
			// 
			this.m_labelFileName.AutoSize = true;
			this.m_labelFileName.Location = new System.Drawing.Point(24, 182);
			this.m_labelFileName.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
			this.m_labelFileName.Name = "m_labelFileName";
			this.m_labelFileName.Size = new System.Drawing.Size(206, 20);
			this.m_labelFileName.TabIndex = 0;
			this.m_labelFileName.Text = "Archivo exportado del FLEx:";
			// 
			// m_textBoxFileName
			// 
			this.m_textBoxFileName.Location = new System.Drawing.Point(22, 223);
			this.m_textBoxFileName.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_textBoxFileName.Name = "m_textBoxFileName";
			this.m_textBoxFileName.Size = new System.Drawing.Size(684, 26);
			this.m_textBoxFileName.TabIndex = 1;
			// 
			// m_buttonBrowse
			// 
			this.m_buttonBrowse.Location = new System.Drawing.Point(726, 217);
			this.m_buttonBrowse.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_buttonBrowse.Name = "m_buttonBrowse";
			this.m_buttonBrowse.Size = new System.Drawing.Size(122, 45);
			this.m_buttonBrowse.TabIndex = 2;
			this.m_buttonBrowse.Text = "Buscar";
			this.m_buttonBrowse.UseVisualStyleBackColor = true;
			this.m_buttonBrowse.Click += new System.EventHandler(this.m_buttonBrowse_Click);
			// 
			// m_groupBoxContent
			// 
			this.m_groupBoxContent.Controls.Add(this.m_numericUpDownStartPageNumber);
			this.m_groupBoxContent.Controls.Add(this.m_labelStartPageNumber);
			this.m_groupBoxContent.Controls.Add(this.m_groupBoxFooter);
			this.m_groupBoxContent.Controls.Add(this.m_textBoxHeader);
			this.m_groupBoxContent.Controls.Add(this.m_labelHeader);
			this.m_groupBoxContent.Location = new System.Drawing.Point(18, 553);
			this.m_groupBoxContent.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxContent.Name = "m_groupBoxContent";
			this.m_groupBoxContent.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxContent.Size = new System.Drawing.Size(716, 343);
			this.m_groupBoxContent.TabIndex = 4;
			this.m_groupBoxContent.TabStop = false;
			this.m_groupBoxContent.Text = "Informacíon";
			// 
			// m_numericUpDownStartPageNumber
			// 
			this.m_numericUpDownStartPageNumber.Location = new System.Drawing.Point(234, 294);
			this.m_numericUpDownStartPageNumber.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_numericUpDownStartPageNumber.Maximum = new decimal(new int[] {
            9999,
            0,
            0,
            0});
			this.m_numericUpDownStartPageNumber.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
			this.m_numericUpDownStartPageNumber.Name = "m_numericUpDownStartPageNumber";
			this.m_numericUpDownStartPageNumber.Size = new System.Drawing.Size(94, 26);
			this.m_numericUpDownStartPageNumber.TabIndex = 9;
			this.m_numericUpDownStartPageNumber.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
			this.m_numericUpDownStartPageNumber.ValueChanged += new System.EventHandler(this.m_numericUpDownStartPageNumber_ValueChanged);
			// 
			// m_labelStartPageNumber
			// 
			this.m_labelStartPageNumber.AutoSize = true;
			this.m_labelStartPageNumber.Location = new System.Drawing.Point(21, 298);
			this.m_labelStartPageNumber.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
			this.m_labelStartPageNumber.Name = "m_labelStartPageNumber";
			this.m_labelStartPageNumber.Size = new System.Drawing.Size(185, 20);
			this.m_labelStartPageNumber.TabIndex = 8;
			this.m_labelStartPageNumber.Text = "Número de página inicial:";
			// 
			// m_groupBoxFooter
			// 
			this.m_groupBoxFooter.Controls.Add(this.m_textBoxCustom);
			this.m_groupBoxFooter.Controls.Add(this.m_radioButtonCustom);
			this.m_groupBoxFooter.Controls.Add(this.m_radioButtonDraft);
			this.m_groupBoxFooter.Controls.Add(this.m_radioButtonNothing);
			this.m_groupBoxFooter.Location = new System.Drawing.Point(15, 92);
			this.m_groupBoxFooter.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxFooter.Name = "m_groupBoxFooter";
			this.m_groupBoxFooter.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxFooter.Size = new System.Drawing.Size(675, 180);
			this.m_groupBoxFooter.TabIndex = 7;
			this.m_groupBoxFooter.TabStop = false;
			this.m_groupBoxFooter.Text = "Pie de página";
			// 
			// m_textBoxCustom
			// 
			this.m_textBoxCustom.Location = new System.Drawing.Point(45, 126);
			this.m_textBoxCustom.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_textBoxCustom.Name = "m_textBoxCustom";
			this.m_textBoxCustom.Size = new System.Drawing.Size(618, 26);
			this.m_textBoxCustom.TabIndex = 7;
			this.m_textBoxCustom.TextChanged += new System.EventHandler(this.m_textBoxCustom_TextChanged);
			// 
			// m_radioButtonCustom
			// 
			this.m_radioButtonCustom.AutoSize = true;
			this.m_radioButtonCustom.Location = new System.Drawing.Point(14, 92);
			this.m_radioButtonCustom.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_radioButtonCustom.Name = "m_radioButtonCustom";
			this.m_radioButtonCustom.Size = new System.Drawing.Size(176, 24);
			this.m_radioButtonCustom.TabIndex = 6;
			this.m_radioButtonCustom.Text = "Texto personalizado";
			this.m_radioButtonCustom.UseVisualStyleBackColor = true;
			this.m_radioButtonCustom.CheckedChanged += new System.EventHandler(this.m_radioButtonCustom_CheckedChanged);
			// 
			// m_radioButtonDraft
			// 
			this.m_radioButtonDraft.AutoSize = true;
			this.m_radioButtonDraft.Checked = true;
			this.m_radioButtonDraft.Location = new System.Drawing.Point(14, 60);
			this.m_radioButtonDraft.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_radioButtonDraft.Name = "m_radioButtonDraft";
			this.m_radioButtonDraft.Size = new System.Drawing.Size(227, 24);
			this.m_radioButtonDraft.TabIndex = 5;
			this.m_radioButtonDraft.TabStop = true;
			this.m_radioButtonDraft.Text = "Borrador (con fecha y hora)";
			this.m_radioButtonDraft.UseVisualStyleBackColor = true;
			this.m_radioButtonDraft.CheckedChanged += new System.EventHandler(this.m_radioButtonDraft_CheckedChanged);
			// 
			// m_radioButtonNothing
			// 
			this.m_radioButtonNothing.AutoSize = true;
			this.m_radioButtonNothing.Location = new System.Drawing.Point(14, 28);
			this.m_radioButtonNothing.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_radioButtonNothing.Name = "m_radioButtonNothing";
			this.m_radioButtonNothing.Size = new System.Drawing.Size(72, 24);
			this.m_radioButtonNothing.TabIndex = 4;
			this.m_radioButtonNothing.Text = "Nada";
			this.m_radioButtonNothing.UseVisualStyleBackColor = true;
			this.m_radioButtonNothing.CheckedChanged += new System.EventHandler(this.m_radioButtonNothing_CheckedChanged);
			// 
			// m_textBoxHeader
			// 
			this.m_textBoxHeader.Location = new System.Drawing.Point(114, 32);
			this.m_textBoxHeader.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_textBoxHeader.Name = "m_textBoxHeader";
			this.m_textBoxHeader.Size = new System.Drawing.Size(574, 26);
			this.m_textBoxHeader.TabIndex = 1;
			this.m_textBoxHeader.TextChanged += new System.EventHandler(this.m_textBoxHeader_TextChanged);
			// 
			// m_labelHeader
			// 
			this.m_labelHeader.AutoSize = true;
			this.m_labelHeader.Location = new System.Drawing.Point(10, 32);
			this.m_labelHeader.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
			this.m_labelHeader.Name = "m_labelHeader";
			this.m_labelHeader.Size = new System.Drawing.Size(75, 20);
			this.m_labelHeader.TabIndex = 0;
			this.m_labelHeader.Text = "Lenguas:";
			// 
			// m_groupBoxOutput
			// 
			this.m_groupBoxOutput.Controls.Add(this.m_groupBoxPageSize);
			this.m_groupBoxOutput.Controls.Add(this.m_checkBoxWebPage);
			this.m_groupBoxOutput.Controls.Add(this.m_checkBoxPDF);
			this.m_groupBoxOutput.Location = new System.Drawing.Point(21, 364);
			this.m_groupBoxOutput.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxOutput.Name = "m_groupBoxOutput";
			this.m_groupBoxOutput.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxOutput.Size = new System.Drawing.Size(711, 143);
			this.m_groupBoxOutput.TabIndex = 3;
			this.m_groupBoxOutput.TabStop = false;
			this.m_groupBoxOutput.Text = "Formas";
			// 
			// m_groupBoxPageSize
			// 
			this.m_groupBoxPageSize.Controls.Add(this.m_radioButton6By85);
			this.m_groupBoxPageSize.Controls.Add(this.m_radioButton66By85);
			this.m_groupBoxPageSize.Controls.Add(this.m_radioButton85By11);
			this.m_groupBoxPageSize.Controls.Add(this.m_radioButton6By9);
			this.m_groupBoxPageSize.Location = new System.Drawing.Point(266, 17);
			this.m_groupBoxPageSize.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxPageSize.Name = "m_groupBoxPageSize";
			this.m_groupBoxPageSize.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxPageSize.Size = new System.Drawing.Size(411, 117);
			this.m_groupBoxPageSize.TabIndex = 2;
			this.m_groupBoxPageSize.TabStop = false;
			this.m_groupBoxPageSize.Text = "Tamaño de página";
			// 
			// m_radioButton6By85
			// 
			this.m_radioButton6By85.AutoSize = true;
			this.m_radioButton6By85.Location = new System.Drawing.Point(10, 34);
			this.m_radioButton6By85.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_radioButton6By85.Name = "m_radioButton6By85";
			this.m_radioButton6By85.Size = new System.Drawing.Size(80, 24);
			this.m_radioButton6By85.TabIndex = 3;
			this.m_radioButton6By85.Text = "6 x 8.5";
			this.m_radioButton6By85.UseVisualStyleBackColor = true;
			this.m_radioButton6By85.CheckedChanged += new System.EventHandler(this.m_radioButton6By85_CheckedChanged);
			// 
			// m_radioButton66By85
			// 
			this.m_radioButton66By85.AutoSize = true;
			this.m_radioButton66By85.Location = new System.Drawing.Point(200, 34);
			this.m_radioButton66By85.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_radioButton66By85.Name = "m_radioButton66By85";
			this.m_radioButton66By85.Size = new System.Drawing.Size(93, 24);
			this.m_radioButton66By85.TabIndex = 2;
			this.m_radioButton66By85.Text = "6.6 x 8.5";
			this.m_radioButton66By85.UseVisualStyleBackColor = true;
			this.m_radioButton66By85.CheckedChanged += new System.EventHandler(this.m_radioButton66By85_CheckedChanged);
			// 
			// m_radioButton85By11
			// 
			this.m_radioButton85By11.AutoSize = true;
			this.m_radioButton85By11.Checked = true;
			this.m_radioButton85By11.Location = new System.Drawing.Point(200, 74);
			this.m_radioButton85By11.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_radioButton85By11.Name = "m_radioButton85By11";
			this.m_radioButton85By11.Size = new System.Drawing.Size(89, 24);
			this.m_radioButton85By11.TabIndex = 1;
			this.m_radioButton85By11.TabStop = true;
			this.m_radioButton85By11.Text = "8.5 x 11";
			this.m_radioButton85By11.UseVisualStyleBackColor = true;
			this.m_radioButton85By11.CheckedChanged += new System.EventHandler(this.m_radioButton85By11_CheckedChanged);
			// 
			// m_radioButton6By9
			// 
			this.m_radioButton6By9.AutoSize = true;
			this.m_radioButton6By9.Location = new System.Drawing.Point(10, 74);
			this.m_radioButton6By9.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_radioButton6By9.Name = "m_radioButton6By9";
			this.m_radioButton6By9.Size = new System.Drawing.Size(67, 24);
			this.m_radioButton6By9.TabIndex = 0;
			this.m_radioButton6By9.Text = "6 x 9";
			this.m_radioButton6By9.UseVisualStyleBackColor = true;
			this.m_radioButton6By9.CheckedChanged += new System.EventHandler(this.m_radioButton6By9_CheckedChanged);
			// 
			// m_checkBoxWebPage
			// 
			this.m_checkBoxWebPage.AutoSize = true;
			this.m_checkBoxWebPage.Location = new System.Drawing.Point(12, 88);
			this.m_checkBoxWebPage.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_checkBoxWebPage.Name = "m_checkBoxWebPage";
			this.m_checkBoxWebPage.Size = new System.Drawing.Size(139, 24);
			this.m_checkBoxWebPage.TabIndex = 1;
			this.m_checkBoxWebPage.Text = "Página de web";
			this.m_checkBoxWebPage.UseVisualStyleBackColor = true;
			this.m_checkBoxWebPage.CheckedChanged += new System.EventHandler(this.m_checkBoxWebPage_CheckedChanged);
			// 
			// m_checkBoxPDF
			// 
			this.m_checkBoxPDF.AutoSize = true;
			this.m_checkBoxPDF.Location = new System.Drawing.Point(12, 40);
			this.m_checkBoxPDF.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_checkBoxPDF.Name = "m_checkBoxPDF";
			this.m_checkBoxPDF.Size = new System.Drawing.Size(152, 24);
			this.m_checkBoxPDF.TabIndex = 0;
			this.m_checkBoxPDF.Text = "PDF (por Prince)";
			this.m_checkBoxPDF.UseVisualStyleBackColor = true;
			this.m_checkBoxPDF.CheckedChanged += new System.EventHandler(this.m_checkBoxPDF_CheckedChanged);
			// 
			// m_progressBar
			// 
			this.m_progressBar.Location = new System.Drawing.Point(18, 932);
			this.m_progressBar.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_progressBar.Name = "m_progressBar";
			this.m_progressBar.Size = new System.Drawing.Size(278, 34);
			this.m_progressBar.TabIndex = 7;
			// 
			// m_groupBoxResult
			// 
			this.m_groupBoxResult.Controls.Add(this.m_radioButtonReversal);
			this.m_groupBoxResult.Controls.Add(this.m_radioButtonDictionary);
			this.m_groupBoxResult.Location = new System.Drawing.Point(21, 28);
			this.m_groupBoxResult.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxResult.Name = "m_groupBoxResult";
			this.m_groupBoxResult.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_groupBoxResult.Size = new System.Drawing.Size(704, 123);
			this.m_groupBoxResult.TabIndex = 8;
			this.m_groupBoxResult.TabStop = false;
			this.m_groupBoxResult.Text = "Parte";
			// 
			// m_radioButtonReversal
			// 
			this.m_radioButtonReversal.AutoSize = true;
			this.m_radioButtonReversal.Location = new System.Drawing.Point(20, 77);
			this.m_radioButtonReversal.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_radioButtonReversal.Name = "m_radioButtonReversal";
			this.m_radioButtonReversal.Size = new System.Drawing.Size(147, 24);
			this.m_radioButtonReversal.TabIndex = 1;
			this.m_radioButtonReversal.TabStop = true;
			this.m_radioButtonReversal.Text = "El índice inverso";
			this.m_radioButtonReversal.UseVisualStyleBackColor = true;
			this.m_radioButtonReversal.CheckedChanged += new System.EventHandler(this.m_radioButtonReversal_CheckedChanged);
			// 
			// m_radioButtonDictionary
			// 
			this.m_radioButtonDictionary.AutoSize = true;
			this.m_radioButtonDictionary.Checked = true;
			this.m_radioButtonDictionary.Location = new System.Drawing.Point(20, 35);
			this.m_radioButtonDictionary.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.m_radioButtonDictionary.Name = "m_radioButtonDictionary";
			this.m_radioButtonDictionary.Size = new System.Drawing.Size(130, 24);
			this.m_radioButtonDictionary.TabIndex = 0;
			this.m_radioButtonDictionary.TabStop = true;
			this.m_radioButtonDictionary.Text = "El Diccionario";
			this.m_radioButtonDictionary.UseVisualStyleBackColor = true;
			// 
			// m_labelProjectLocation
			// 
			this.m_labelProjectLocation.AutoSize = true;
			this.m_labelProjectLocation.Location = new System.Drawing.Point(24, 277);
			this.m_labelProjectLocation.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
			this.m_labelProjectLocation.Name = "m_labelProjectLocation";
			this.m_labelProjectLocation.Size = new System.Drawing.Size(141, 20);
			this.m_labelProjectLocation.TabIndex = 9;
			this.m_labelProjectLocation.Text = "Proyecto del FLEx:";
			// 
			// m_comboBoxFLExProjects
			// 
			this.m_comboBoxFLExProjects.FormattingEnabled = true;
			this.m_comboBoxFLExProjects.Location = new System.Drawing.Point(184, 275);
			this.m_comboBoxFLExProjects.Name = "m_comboBoxFLExProjects";
			this.m_comboBoxFLExProjects.Size = new System.Drawing.Size(522, 28);
			this.m_comboBoxFLExProjects.TabIndex = 10;
			this.m_comboBoxFLExProjects.SelectedIndexChanged += new System.EventHandler(this.m_comboBoxFLExProjects_SelectedIndexChanged);
			// 
			// FLExAMXB
			// 
			this.AcceptButton = this.m_buttonOK;
			this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.CancelButton = this.m_buttonCancel;
			this.ClientSize = new System.Drawing.Size(870, 1013);
			this.Controls.Add(this.m_comboBoxFLExProjects);
			this.Controls.Add(this.m_labelProjectLocation);
			this.Controls.Add(this.m_groupBoxResult);
			this.Controls.Add(this.m_progressBar);
			this.Controls.Add(this.m_groupBoxOutput);
			this.Controls.Add(this.m_groupBoxContent);
			this.Controls.Add(this.m_buttonBrowse);
			this.Controls.Add(this.m_textBoxFileName);
			this.Controls.Add(this.m_labelFileName);
			this.Controls.Add(this.m_buttonCancel);
			this.Controls.Add(this.m_buttonOK);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
			this.Name = "FLExAMXB";
			this.Text = "FLEx a Diccionario MXB";
			this.m_groupBoxContent.ResumeLayout(false);
			this.m_groupBoxContent.PerformLayout();
			((System.ComponentModel.ISupportInitialize)(this.m_numericUpDownStartPageNumber)).EndInit();
			this.m_groupBoxFooter.ResumeLayout(false);
			this.m_groupBoxFooter.PerformLayout();
			this.m_groupBoxOutput.ResumeLayout(false);
			this.m_groupBoxOutput.PerformLayout();
			this.m_groupBoxPageSize.ResumeLayout(false);
			this.m_groupBoxPageSize.PerformLayout();
			this.m_groupBoxResult.ResumeLayout(false);
			this.m_groupBoxResult.PerformLayout();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Button m_buttonOK;
		private System.Windows.Forms.Button m_buttonCancel;
		private System.Windows.Forms.Label m_labelFileName;
		private System.Windows.Forms.TextBox m_textBoxFileName;
		private System.Windows.Forms.Button m_buttonBrowse;
		private System.Windows.Forms.GroupBox m_groupBoxContent;
		private System.Windows.Forms.TextBox m_textBoxHeader;
		private System.Windows.Forms.Label m_labelHeader;
		private System.Windows.Forms.GroupBox m_groupBoxOutput;
		private System.Windows.Forms.CheckBox m_checkBoxWebPage;
		private System.Windows.Forms.CheckBox m_checkBoxPDF;
		private System.Windows.Forms.ProgressBar m_progressBar;
		private System.Windows.Forms.GroupBox m_groupBoxFooter;
		private System.Windows.Forms.TextBox m_textBoxCustom;
		private System.Windows.Forms.RadioButton m_radioButtonCustom;
		private System.Windows.Forms.RadioButton m_radioButtonDraft;
		private System.Windows.Forms.RadioButton m_radioButtonNothing;
		private System.Windows.Forms.NumericUpDown m_numericUpDownStartPageNumber;
		private System.Windows.Forms.Label m_labelStartPageNumber;
		private System.Windows.Forms.GroupBox m_groupBoxResult;
		private System.Windows.Forms.RadioButton m_radioButtonReversal;
		private System.Windows.Forms.RadioButton m_radioButtonDictionary;
		private System.Windows.Forms.GroupBox m_groupBoxPageSize;
		private System.Windows.Forms.RadioButton m_radioButton85By11;
		private System.Windows.Forms.RadioButton m_radioButton6By9;
		private System.Windows.Forms.RadioButton m_radioButton66By85;
		private System.Windows.Forms.RadioButton m_radioButton6By85;
		private System.Windows.Forms.Label m_labelProjectLocation;
		private System.Windows.Forms.ComboBox m_comboBoxFLExProjects;
	}
}

