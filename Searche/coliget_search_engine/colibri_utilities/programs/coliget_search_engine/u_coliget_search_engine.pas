// 003 u_coliget_search_engine
// 23 dec 2004

// -- (C) Felix John COLIBRI 2004
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_coliget_search_engine;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    extension_edit_: TEdit;
    evaluate_trial_: TButton;
    DirectoryListBox1: TDirectoryListBox;
    all_dir_: TButton;
    all_dir_recursive_: TButton;
    FileListBox1: TFileListBox;
    Panel2: TPanel;
    exit_: TButton;
    clear_: TButton;
    PageControl1: TPageControl;
    query_: TTabSheet;
    expressions_: TTabSheet;
    search_edit_: TEdit;
    case_insensitive_: TCheckBox;
    sample_requests_listbox_: TListBox;
    felix_: TButton;
    programs_: TButton;
    procedure FormCreate(Sender: TObject);
    procedure all_dir_Click(Sender: TObject);
    procedure all_dir_recursive_Click(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    procedure exit_Click(Sender: TObject);
    procedure clear_Click(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure evaluate_trial_Click(Sender: TObject);
    procedure sample_requests_listbox_Click(Sender: TObject);
    procedure extension_edit_Change(Sender: TObject);
    procedure felix_Click(Sender: TObject);
    procedure programs_Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation
  uses u_types_constants, u_c_log, u_c_display
      , u_file, u_dir
      , u_strings
      , u_handle_files_in_dirs
      , u_c_text_searcher
      , u_c_request_evaluator
      ;

    {$R *.DFM}

 
    const k_local_site_path= 'c:\programs\felix-colibri_local\';
          k_programs_path= '..\..\';

          k_initial_directory= k_programs_path;

          // -- some expressions
          k_sample_path= '..\programs\coliget_search_engine\_data\';
            k_sample_file_name= 'sample_requests.txt';

    var g_path: String= k_initial_directory;

        g_file_count: Integer= 0;
        g_not_extension_count: Integer= 0;

        g_total_size: Integer= 0;
        g_total_line_count: Integer= 0;

    procedure check_file_call_back(p_level: Integer; p_path, p_file_name: String;
        p_pt_data: Pointer);
      var l_extension, l_target_extension: String;
          l_c_text_searcher: c_text_searcher;
          l_text_to_search: String;
          l_request: String;
          l_relative_path: String;
      begin
        l_target_extension:= LowerCase(Form1.extension_edit_.Text);
        Delete(l_target_extension, 1, 1);
        if l_target_extension= '.*'
          then
          else begin
              l_extension:= LowerCase(ExtractFileExt(p_file_name));
              if l_extension<> l_target_extension
                then begin
                    Inc(g_not_extension_count);
                    Exit;
                  end;
            end;

        Inc(g_file_count);

        with tStringList.Create do
        begin
          LoadFromFile(p_path+ '\'+ p_file_name);
          If Length(Trim(Text))= 0
            then Exit;

          Inc(g_total_line_count, Count);
          Inc(g_total_size, Length(Text));

          l_text_to_search:= Text;
          l_request:= Form1.search_edit_.Text;

          with c_request_evaluator.create_request_evaluator('req') do
          begin
            tokenize_request(l_request);

            l_c_text_searcher:= c_text_searcher.create_text_searcher('txt');
            with l_c_text_searcher do
            begin
              if Form1.case_insensitive_.Checked
                then begin
                    l_text_to_search:= LowerCase(l_text_to_search);
                  end;
              initialize_text(l_text_to_search);

              if f_evaluate_request(l_c_text_searcher)
                then begin
                    // -- only display the relative path
                    l_relative_path:= f_segment(p_path, g_path);
                    display('-> '+ l_relative_path);
                    display('     '+ p_file_name);
                  end
                else ; // display(p_file_name);

              Free;
            end; // with l_c_text_searcher do

            Free;
          end; // with c_request_evaluator

          Free;
        end; // with l_c_lines
      end; // check_file_call_back

    // -- events

    procedure TForm1.FormCreate(Sender: TObject);
      begin
        initialize_display(Memo1.Lines);
        initialize_default_log;

        // -- get the sample BEFORE file listbox assignment
        // check_path_and_name(k_sample_path+ k_sample_file_name);
        sample_requests_listbox_.Items.LoadFromFile(k_sample_path+ k_sample_file_name);

        FileListBox1.Mask:= extension_edit_.Text;

        set_directory_listbox_directory(DirectoryListBox1, g_path);

        // g_c_text_searcher:= c_text_searcher.create_text_searcher('search');
      end; // FormCreate

    procedure TForm1.exit_Click(Sender: TObject);
      begin
        Close;
      end; // close_Click

    procedure TForm1.clear_Click(Sender: TObject);
      begin
        clear_display;
      end; // clear_Click

    procedure TForm1.DirectoryListBox1Change(Sender: TObject);
      begin
        with DirectoryListBox1 do
          g_path:= GetItemPath(ItemIndex)+ '\';
        Caption:= g_path;
      end; // DirectoryListBox1Change

    procedure TForm1.felix_Click(Sender: TObject);
      begin
        set_directory_listbox_directory(DirectoryListBox1, k_local_site_path);
      end; // felix_Click

    procedure TForm1.programs_Click(Sender: TObject);
      begin
        set_directory_listbox_directory(DirectoryListBox1, k_programs_path);
      end; // programs_Click

    procedure TForm1.extension_edit_Change(Sender: TObject);
      begin
        FileListBox1.Mask:= extension_edit_.Text;
      end; // extension_edit_Change

    procedure TForm1.sample_requests_listbox_Click(Sender: TObject);
      begin
        with sample_requests_listbox_ do
          search_edit_.Text:= Items[ItemIndex];

        PageControl1.ActivePage:= query_;
      end; // sample_requests_listbox_Click

    // -- call handler

    procedure TForm1.FileListBox1Click(Sender: TObject);
        // -- the file clicked in the bottom list_box
      var l_path, l_name: String;
      begin
        l_path:= DirectoryListBox1.Directory;
        with FileListbox1 do
          l_name:= Items[ItemIndex];

        check_file_call_back(0, l_path+ '\', l_name, Nil);
      end; // FileListBox1Click

    procedure handle_the_files(p_set_of_dir_handling_type: t_dir_handling_types);
      var l_extension: String;
          l_path: String;
      begin
        l_path:= Form1.DirectoryListBox1.Directory;
        l_extension:= Form1.extension_edit_.Text;
        Delete(l_extension, 1, 1);
        l_extension:= UpperCase(l_extension);
        display(l_extension);

        display_line;
        display('handle '+ l_path+ ' '+ l_extension);
        display_line;

        g_file_count:= 0;
        g_not_extension_count:= 0;
        g_total_size:= 0;
        g_total_line_count:= 0;

        handle_all_files_recursive(1, l_path, l_extension,
            p_set_of_dir_handling_type, check_file_call_back, Nil);

        display_line;
        display(Format('files %7d   ', [g_file_count]));
        display(Format('bytes %7d   %7d K ', [g_total_size, g_total_size div 1024]));
        display(Format('lines %7d   %7d K ', [g_total_line_count, g_total_line_count div 1024]));
      end; // handle_the_files

    procedure TForm1.all_dir_Click(Sender: TObject);
        // -- all the file of this folder (non rec)
      begin
        handle_the_files([e_dir_handle_file]);
      end; // btn_all_dirClick

    procedure TForm1.all_dir_recursive_Click(Sender: TObject);
        // -- all the file of this folder (rec)
      begin
        handle_the_files([e_dir_recursive, e_dir_handle_file]);
      end; // btn_all_dir_recursClick

    // -- debug

    procedure TForm1.evaluate_trial_Click(Sender: TObject);
        // -- debug: try out the evaluator
      var l_c_text_searcher: c_text_searcher;
          l_text_to_search: String;
          l_request: String;
      begin
        l_text_to_search:= 'aaa bbb unit vax uh un ';
        // l_request:= 'unit AND vaX OR "uh u"';
        l_request:= '(uml [OR pattern) AND course';

        search_edit_.Text:= l_request;

        l_c_text_searcher:= c_text_searcher.create_text_searcher('txt');
        with l_c_text_searcher do
        begin
          initialize_text(l_text_to_search);
        end; // with l_c_text_searcher do

        with c_request_evaluator.create_request_evaluator('req') do
        begin
          tokenize_request(l_request);
          redisplay_request;

          display_line;
          display('req ='+ l_request);
          display('txt ='+ l_c_text_searcher.m_text_to_search);

          if f_evaluate_request(l_c_text_searcher)
            then display('ok eval')
            else display('NOK eval');
        end; // with c_request_evaluator
      end; // evaluate_Click


end.


