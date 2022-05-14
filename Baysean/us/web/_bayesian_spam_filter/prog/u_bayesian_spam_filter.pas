// 002 u_mail_spam_bayes
// 25 mar 2008

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_bayesian_spam_filter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DirectoryListBox1: TDirectoryListBox;
    exit_: TButton;
    clear_: TButton;
    Panel4: TPanel;
    all_dir_: TButton;
    all_dir_recursive_: TButton;
    Splitter2: TSplitter;
    FileListBox1: TFileListBox;
    Splitter1: TSplitter;
    PageControl1: TPageControl;
    display_: TTabSheet;
    Memo1: TMemo;
    compute: TButton;
    Panel5: TPanel;
    spam_: TCheckBox;
    display_frequency_: TButton;
    compute_probabilities_: TButton;
    test_ok_mail_: TButton;
    display_proba_: TButton;
    max_spam_edit_: TEdit;
    Label3: TLabel;
    max_ok_edit_: TEdit;
    Label4: TLabel;
    test_spam_mail_: TButton;
    all_: TButton;
    Label2: TLabel;
    best_count_edit_: TEdit;
    spam_sampling_edit_: TEdit;
    ok_sampling_edit_: TEdit;
    Label5: TLabel;
    result_: TTabSheet;
    result_panel_: TPanel;
    result_listbox_: TListBox;
    Splitter3: TSplitter;
    result_memo_: TMemo;
    load_mail_: TCheckBox;
    parse_mail_: TTabSheet;
    Panel7: TPanel;
    mail_header_memo_: TMemo;
    Splitter4: TSplitter;
    mail_mime_content_memo_: TMemo;
    Splitter5: TSplitter;
    PageControl2: TPageControl;
    debug_reader_: TTabSheet;
    mail_content_: TTabSheet;
    mail_memo_: TMemo;
    mail_content_memo_: TMemo;
    raw_mail_: TTabSheet;
    raw_mail_memo_: TMemo;
    mail_: TCheckBox;
    token_list_: TTabSheet;
    test_token_list_memo_: TMemo;
    sorted_token_list_: TTabSheet;
    test_sorted_token_listbox_: TListBox;
    Panel6: TPanel;
    sort_: TButton;
    parameters_: TTabSheet;
    new_mail_: TButton;
    train_spam_: TLabel;
    train_ok_: TLabel;
    test_spam_: TLabel;
    test_ok_: TLabel;
    train_time_: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    token_length_min_edit_: TEdit;
    buffer_size_max_edit_: TEdit;
    ok_token_weight_edit_: TEdit;
    min_token_count_edit_: TEdit;
    score_min_edit_: TEdit;
    likely_spam_score_edit_: TEdit;
    certain_spam_score_edit_: TEdit;
    certain_spam_count_edit_: TEdit;
    set_parameters_: TButton;
    procedure FormCreate(Sender: TObject);
    procedure all_dir_Click(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    procedure exit_Click(Sender: TObject);
    procedure clear_Click(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure all_dir_recursive_Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure computeClick(Sender: TObject);
    procedure display_frequency_Click(Sender: TObject);
    procedure compute_probabilities_Click(Sender: TObject);
    procedure test_ok_mail_Click(Sender: TObject);
    procedure display_proba_Click(Sender: TObject);
    procedure test_spam_mail_Click(Sender: TObject);
    procedure all_Click(Sender: TObject);
    procedure result_listbox_Click(Sender: TObject);
    procedure sort_Click(Sender: TObject);
    procedure set_parameters_Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation
  uses Math, u_types_constants, u_c_log, u_c_display
      , u_file, u_dir
      , u_c_ini_file
      , u_strings
      , u_handle_files_in_dirs

      , u_c_string_hash_table
      , u_c_bayes_spam_filter_2
      , u_c_timer_now
      , u_c_most_interesting_list

      , u_c_mail_filter_result_list
      , u_c_mail_scanner_4
      , u_c_mail_parser
      ;

    {$R *.DFM}

      
    const //k_initial_directory= 'c:\prog\web\utils\downloader\';
    k_initial_directory = 'K:\@Projetos_em_andamento\EmC2010\Baysean\us\web\_bayesian_spam_filter';
            k_extension= '.pas';
            k_file_name= 'pascal.pas';

          k_xxx_path_ini_key=   'ini_xxx_path';

          //k_xxx_path=   'c:\prog\xxx\';
          k_xxx_path='K:\@Projetos_em_andamento\EmC2010\Baysean\us\web\_bayesian_spam_filter\prog';

          // -- used to split training / test
          k_ok_threshhold= 40;
          k_spam_threshhold= 120;

    var g_path: String= k_xxx_path;
        g_file_name: String= k_file_name;
        g_c_ini_file: c_ini_file= Nil;
        g_file_count: Integer= 0;

        g_spam_test_count: Integer= 0;
        g_ok_test_count: Integer= 0;

        g_root_path: String= '';

        g_ok_sampling, g_spam_sampling: Integer;
        g_c_bayes_spam_filter: c_bayes_spam_filter= Nil;

        g_test_path: String;

    procedure display_path_and_file;
      begin
        Form1.Caption:= g_path+ g_file_name;
      end; // display_path_and_file

    procedure set_panel_color(p_c_panel: tPanel; p_color: Integer);
      begin
        p_c_panel.Color:= p_color;
        Application.ProcessMessages;
      end; // set_panel_color

    function f_is_test_file(p_file_name: String; p_file_index, p_threshhold: Integer): Boolean;
      var l_year: String;
      begin
        l_year:= Copy(p_file_name, 1, 4);
        Result:= (l_year>= '2008')
            and ((p_file_index mod p_threshhold)= 0)
      end; // f_is_ok_test

    procedure my_call_back(p_level: Integer; p_path, p_file_name: String;
        p_pt_data: Pointer);
      var l_spam_max, l_ok_max: Integer;
      begin
        Inc(g_file_count);

        if g_c_bayes_spam_filter= nil
          then begin
              g_c_bayes_spam_filter:= c_bayes_spam_filter.create_bayes_spam_filter('');
            end;

        with Form1, g_c_bayes_spam_filter do
        begin
          // -- analyze mail structure or not
          g_c_bayes_spam_filter.m_e_mail_scanning:= mail_.Checked;

          l_spam_max:= StrToInt(Form1.max_spam_edit_.Text);
          l_ok_max:= StrToInt(Form1.max_ok_edit_.Text);
          if spam_.Checked and
              ((m_spam_e_mail_count< l_spam_max) or (l_spam_max= -1))
            then begin
                display('spam '+ p_file_name);
                if f_is_test_file(p_file_name, m_spam_e_mail_count, g_spam_sampling)
                  then begin
                      // stop('copy '+ p_file_name);
                      copy_file(p_path+ p_file_name, g_root_path+ 'test_spam\'+ p_file_name);
                      Inc(g_spam_test_count);
                    end
                  else begin
                      g_c_bayes_spam_filter.add_file_tokens(p_path+ p_file_name, Form1.spam_.Checked);
                    end;
                Inc(m_spam_e_mail_count);
              end
            else
              if not Form1.spam_.Checked
                  and ((m_ok_e_mail_count< l_ok_max) or (l_ok_max= -1))
                then begin
                    display('ok '+ p_file_name);
                    g_c_bayes_spam_filter.add_file_tokens(p_path+ p_file_name, Form1.spam_.Checked);
                    if f_is_test_file(p_file_name, m_ok_e_mail_count, g_ok_sampling)
                      then begin
                          copy_file(p_path+ p_file_name, g_root_path+ 'test_ok\'+ p_file_name);
                          Inc(g_ok_test_count);
                        end
                      else begin
                          g_c_bayes_spam_filter.add_file_tokens(p_path+ p_file_name, Form1.spam_.Checked);
                        end;
                    Inc(m_ok_e_mail_count);
                  end;
        end; // with Form1
      end; // my_call_back

    // -- events

    procedure TForm1.FormCreate(Sender: TObject);
      begin
        initialize_display(Memo1.Lines);
        initialize_default_log;

        g_c_ini_file:= c_ini_file.create_ini_file('');
        with g_c_ini_file do
        begin
          // -- whatever is in "fig_ini.txt"
          load_from_default_file;

          // -- initialize the variables with INI or, if none, with constants
          g_path:= f_initialize_parameter(k_xxx_path_ini_key, k_xxx_path);
        end; // with g_c_ini_file

        // check_name(k_initial_directory);
        // DirectoryListBox1.Directory:= k_initial_directory;
        set_directory_listbox_directory(DirectoryListBox1, g_path);

        all_Click(Nil);
      end; // FormCreate

    procedure TForm1.exit_Click(Sender: TObject);
      begin
        Close;
      end; // exit_Click

    procedure TForm1.clear_Click(Sender: TObject);
      begin
        clear_display;
      end; // clear_Click

    procedure TForm1.DirectoryListBox1Change(Sender: TObject);
      begin
        with DirectoryListBox1 do
          g_path:= GetItemPath(ItemIndex)+ '\';
        g_c_ini_file.set_parameter(k_xxx_path_ini_key, g_path);
      end; // DirectoryListBox1Change

    // -- call handler

    procedure load_and_display_mail(p_full_file_name: String);
        // -- debug
      begin
        with Form1 do
        begin
          initialize_display(mail_memo_.Lines);

          raw_mail_memo_.Lines.LoadFromFile(p_full_file_name);

          with c_mail_parser.create_mail_parser('', p_full_file_name) do
          begin
            with mail_header_memo_.Lines do
            begin
              Clear;
              Add('From:    '+ m_from);
              Add('To:      '+ m_to);
              Add('Subject: '+ m_subject);
              Add('Date:    '+ m_date);
            end;

            mail_mime_content_memo_.Lines.Assign(m_c_mime_content_type_list);

            display_line;
            display(Format('txt %3d  html %3d ', [Length(m_text_content), Length(m_html_content)]));

            mail_content_memo_.Lines.Clear;
            if m_text_content<> ''
              then mail_content_memo_.Lines.Add(m_text_content);
            if m_html_content<>''
              then mail_content_memo_.Lines.Add(m_html_content);

            Free;
          end; // with c_mail_parser.create_mail_parser

          initialize_display(Memo1.Lines);
        end; // with Form1
      end; // load_and_display_mail

    procedure TForm1.FileListBox1Click(Sender: TObject);
      // -- the file clicked in the bottom list_box

      procedure reparse_html_Click(Sender: TObject);
          // -- has a raw text in the memo, parse it again
          // --   usually done when clicks in the FileListBox
        var l_c_test_mail_token_frequency_list: c_hash_table;
        begin
          if Length(raw_mail_memo_.Text)= 0
            then Exit;

          initialize_display(mail_memo_.Lines);
          mail_memo_.Lines.Clear;
          display('> reparse_html_Click');

          with g_c_bayes_spam_filter do
          begin
            m_e_mail_scanning:= mail_.Checked;
            m_debug_frequency_parsing:= True;

            l_c_test_mail_token_frequency_list:= c_hash_table.create_hash_table('');

            with c_mail_scanner.create_mail_scanner('', m_token_length_min) do
            begin
              assign_string_buffer(raw_mail_memo_.Text);

              if m_e_mail_scanning
                then _add_e_mail_file_tokens(f_c_self, l_c_test_mail_token_frequency_list, True)
                else _add_raw_tokens(f_c_self, l_c_test_mail_token_frequency_list, True);

              Free;
            end; // with c_mail_scanner

            with l_c_test_mail_token_frequency_list do
            begin
              initialize_display(test_token_list_memo_.Lines);
              clear_display;
              display(Format('len txt %7d  html %7d ', [m_token_length, m_html_token_length]));
              display_line;
              display_hash_table;

              test_sorted_token_listbox_.Items.Clear;
              with c_hash_iterator.create_hash_iterator('', l_c_test_mail_token_frequency_list) do
              begin
                while f_move_next do
                  with f_pt_current_hash_data^ do
                    test_sorted_token_listbox_.Items.Add(Format('%-35s  %6d', [m_hash_string, m_hash_frequency]));

                Free;
              end; // with c_hash_iterator.create_hash_iterator

              Free;
            end; // with l_c_test_mail_token_frequency_list

            m_debug_frequency_parsing:= False;
          end; // with g_c_bayes_spam_filter

          initialize_display(Memo1.Lines);
          display('< reparse_html_Click');
        end; // reparse_html_Click

      var l_path, l_name: String;

      begin // FileListBox1Click
        l_path:= DirectoryListBox1.Directory+ '\';
        with FileListbox1 do
          l_name:= Items[ItemIndex];

        g_file_count:= 0;

        FreeAndNil(g_c_bayes_spam_filter);
        g_c_bayes_spam_filter:= c_bayes_spam_filter.create_bayes_spam_filter('');
        with g_c_bayes_spam_filter do
        begin
          m_spam_e_mail_count:= 0;
          m_ok_e_mail_count:= 0;
        end;

        if load_mail_.Checked
          then begin
              PageControl1.ActivePage:= parse_mail_;
              load_and_display_mail(l_path+ l_name);

              reparse_html_Click(Nil);
            end
          else my_call_back(0, l_path, l_name, Nil);
      end; // FileListBox1Click

    procedure handle_the_files(p_dir_handling_types: t_dir_handling_types);
      var l_extension: String;
          l_path: String;
      begin
        g_file_count:= 0;
        l_path:= f_without_ending_slash(g_path);

        l_extension:= Form1.FileListBox1.Mask;
        Delete(l_extension, 1, 1);
        l_extension:= UpperCase(l_extension);

        display_line;
        display('handle_non_rec of '+ l_path+ ' '+ l_extension);
        display_line;
        handle_all_files_recursive(1, l_path, l_extension,
            p_dir_handling_types, my_call_back, Nil);

        display_line;
        display(Format('FINISHED %6d  ', [g_file_count]));
      end; // handle_the_files

    procedure TForm1.all_dir_Click(Sender: TObject);
      // -- all the file of this folder (non rec)
      begin
        handle_the_files([e_dir_handle_file]);
      end; // btn_all_dirClick

    procedure TForm1.all_dir_recursive_Click(Sender: TObject);
      begin
        handle_the_files([e_dir_handle_file, e_dir_recursive]);
      end; // all_dir_recursive_Click

    procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
      begin
        g_c_ini_file.save_to_default_file;
      end; // FormClose

    procedure TForm1.all_Click(Sender: TObject);
      begin
        max_spam_edit_.Text:= '-1';
        max_ok_edit_.Text:= '-1';
      end; // all_Click

    procedure TForm1.set_parameters_Click(Sender: TObject);
        // -- additional parameters
      begin
        if g_c_bayes_spam_filter= Nil
          then Exit;

        with g_c_bayes_spam_filter do
        begin
          // -- do not analize token smaller than
          m_token_length_min:= StrToInt(token_length_min_edit_.Text);
          // -- do not scan more than this limit
          m_buffer_size_max:= StrToInt(buffer_size_max_edit_.Text);

          // --   good words are multiplied by 2
          m_ok_token_weight:= StrToInt(ok_token_weight_edit_.Text);

          // -- only compute probability if at least 5 occurences
          m_min_token_count:= StrToInt(min_token_count_edit_.Text);

          // -- if in spam only or in ok_only
          m_score_min:= StrToFloat(score_min_edit_.Text);
          // m_xxx:= StrToFloat(m_xxx_edit_.Text);

          // -- spam only, < 10 occurences
          m_likely_spam_score:= StrToFloat(likely_spam_score_edit_.Text);
          // -- spam only, > 10 occurences
          m_certain_spam_score:= StrToFloat(certain_spam_score_edit_.Text);
          m_certain_spam_count:= StrToInt(certain_spam_count_edit_.Text);
        end; // with g_c_bayes_spam_filter
      end; // set_parameters_Click

    function f_stats(p_caption: String; p_mail_count, p_token_count: Integer): String;
      begin
        Result:= Format('%-17s %7d (%8d)', [p_caption, p_mail_count, p_token_count]);
      end; // f_stats

    procedure TForm1.computeClick(Sender: TObject);
      var l_c_timer_now: c_timer_now;
      begin
        set_panel_color(result_panel_, clRed);
        g_root_path:= g_path;

        // -- empty the test folders
        f_erase_directory_files(g_root_path+ 'test_ok\');
        f_erase_directory_files(g_root_path+ 'test_spam\');
        // stop('');

        g_ok_sampling:= StrToInt(ok_sampling_edit_.Text);
        g_spam_sampling:= StrToInt(spam_sampling_edit_.Text);

        FreeAndNil(g_c_bayes_spam_filter);
        g_c_bayes_spam_filter:= c_bayes_spam_filter.create_bayes_spam_filter('');
        with g_c_bayes_spam_filter do
        begin
          m_spam_e_mail_count:= 0;
          m_ok_e_mail_count:= 0;
        end;

        g_spam_test_count:= 0;
        g_ok_test_count:= 0;

        l_c_timer_now:= c_timer_now.create_timer_now('');
        set_directory_listbox_directory(DirectoryListBox1, g_root_path+ 'spam\');
        spam_.Checked:= True;
        all_dir_Click(Nil);
        display('spam_count '+ IntToStr(g_c_bayes_spam_filter.m_c_spam_hash_token_frequency_list.f_hash_data_count));

        set_directory_listbox_directory(DirectoryListBox1, g_root_path+ 'ok\');
        spam_.Checked:= False;
        all_dir_Click(Nil);
        display('ok_count   '+ IntToStr(g_c_bayes_spam_filter.m_c_ok_hash_token_frequency_list.f_hash_data_count));

        display_line;
        display('time '+ l_c_timer_now.f_display_delta+ ' '+ FormatDateTime('hh:nn:ss', Now));
        train_time_.Caption:= 'train_time '+ l_c_timer_now.f_display_delta;

        with g_c_bayes_spam_filter do
        begin
          display(Format('spam_count file=%7d word=%7d    ok_count file=%7d  word=%7d ',
              [m_spam_e_mail_count, g_c_bayes_spam_filter.m_c_spam_hash_token_frequency_list.f_hash_data_count,
               m_ok_e_mail_count, g_c_bayes_spam_filter.m_c_ok_hash_token_frequency_list.f_hash_data_count]));

          train_spam_.Caption:= f_stats('train_spam_ (tok)', m_spam_e_mail_count, g_c_bayes_spam_filter.m_c_spam_hash_token_frequency_list.f_hash_data_count);
          train_ok_.Caption:= f_stats('train_ok_ (tok)', m_ok_e_mail_count, g_c_bayes_spam_filter.m_c_ok_hash_token_frequency_list.f_hash_data_count);

          display(Format('samples  test %3d ok %3d', [g_spam_test_count, g_ok_test_count]));

          display(Format('e-mail_length avg=%7d  max=%7d',
              [Round(g_c_bayes_spam_filter.m_total_e_mail_length/ (m_spam_e_mail_count+ m_ok_e_mail_count+ 1)),
              g_c_bayes_spam_filter.m_max_e_mail_length]) );
        end;

        set_directory_listbox_directory(DirectoryListBox1, g_root_path);
        set_panel_color(result_panel_, clLime);
      end; // computeClick

    procedure TForm1.display_frequency_Click(Sender: TObject);
      begin
        if (g_c_bayes_spam_filter= Nil) or (g_c_bayes_spam_filter.m_c_ok_hash_token_frequency_list= Nil)
          then begin
              display('not_yet_computed');
              Exit;
            end;
        g_c_bayes_spam_filter.m_c_ok_hash_token_frequency_list.display_hash_table;
        g_c_bayes_spam_filter.m_c_spam_hash_token_frequency_list.display_hash_table;
      end; // display_frequency_Click

    procedure TForm1.compute_probabilities_Click(Sender: TObject);
      begin
        set_panel_color(result_panel_, clRed);
        g_c_bayes_spam_filter.compute_spam_probabilities;
        set_panel_color(result_panel_, clLime);
      end; // compute_probabilities_Click

    procedure TForm1.display_proba_Click(Sender: TObject);
      begin
        if (g_c_bayes_spam_filter= Nil) or (g_c_bayes_spam_filter.m_c_spam_token_probability_list= Nil)
          then begin
              display('not_yet_computed');
              Exit;
            end;

        with c_hash_iterator.create_hash_iterator('', g_c_bayes_spam_filter.m_c_spam_token_probability_list) do
        begin
          while f_move_next do
            with f_pt_current_hash_data^ do
            begin
              display(Format('%5.5f  %7d ', [m_hash_probability, m_hash_frequency])+ m_hash_string);
            end;
          Free;
        end; // with c_hash_iterator.create_hash_iterator
      end; // display_proba_Click

    procedure TForm1.sort_Click(Sender: TObject);
        // -- display the 15 highest and lowest

      procedure display_highest(p_offset: Double);
        var l_c_most_interesting_list: c_most_interesting_list;
        begin
          l_c_most_interesting_list:=
            c_most_interesting_list.create_most_interesting_list('', 20);

          with c_hash_iterator.create_hash_iterator('',
            g_c_bayes_spam_filter.m_c_spam_token_probability_list) do
          begin
            while f_move_next do
              with f_pt_current_hash_data^ do
                if p_offset= 0
                  then l_c_most_interesting_list.add_most_interesting_decreasing(
                    m_hash_probability, m_hash_probability, m_hash_string)
                  else l_c_most_interesting_list.add_most_interesting_decreasing(
                    1- m_hash_probability, m_hash_probability, m_hash_string);

            Free;
          end; // with c_hash_iterator.create_hash_iterator

          l_c_most_interesting_list.display_most_interesting_list(0, 7);
          l_c_most_interesting_list.Free
        end; // display_highest

      begin // sort_Click
        display_line;
        display('highest spam probability');
        display_highest(0);

        display_line;
        display('highest ok probability');
        display_highest(1);
      end; // sort_Click

    procedure rank_e_mails(p_e_mail_path: String;
        p_c_result_label: tLabel; p_caption: String);
      var l_file_index: Integer;
          l_file_name: String;
          l_total_token_count: Integer;

          l_ratio: Double;
          l_c_result_list: tStringList;
          l_mail_token_count: Integer;

          l_c_mail_filter_result: c_mail_filter_result;
          l_result_key: String;
      begin
        with Form1 do
        begin
          set_panel_color(result_panel_, clRed);
          g_root_path:= g_path;
          g_test_path:= g_root_path+ p_e_mail_path;
          set_directory_listbox_directory(DirectoryListBox1, g_test_path);

          g_c_bayes_spam_filter.m_interesting_word_count:= StrToInt(best_count_edit_.Text);
          g_c_bayes_spam_filter.m_e_mail_scanning:= mail_.Checked;

          l_c_result_list:= tStringList.Create;

          result_listbox_.Items.Clear;
          l_total_token_count:= 0;

          with FileListBox1 do
            for l_file_index:= 0 to Count- 1 do
            begin
              l_file_name:= Items[l_file_index];
              l_ratio:= g_c_bayes_spam_filter.f_test_mail(g_path+ l_file_name,
                  l_c_result_list, l_mail_token_count);

              l_result_key:= Format('%1.8f ', [l_ratio])+ l_file_name;
              l_c_mail_filter_result:= c_mail_filter_result.create_mail_filter_result(
                  l_result_key,
                  l_file_name,
                  l_c_result_list);

              result_listbox_.Items.AddObject(l_result_key, l_c_mail_filter_result);
              Inc(l_total_token_count, l_mail_token_count);
            end; // with FileListBox1, for l_file_index

          p_c_result_label.Caption:=
              f_stats(p_caption, FileListBox1.Count, l_total_token_count);

          l_c_result_list.Free;
          set_directory_listbox_directory(DirectoryListBox1, g_root_path);
          set_panel_color(result_panel_, clLime);
        end; // with Form1
      end; // rank_e_mails

    procedure TForm1.test_ok_mail_Click(Sender: TObject);
      begin
        rank_e_mails('test_ok\', test_ok_, 'test_ok (tok)')
      end; // test_ok_mail_Click

    procedure TForm1.test_spam_mail_Click(Sender: TObject);
      begin
        rank_e_mails('test_spam\', test_spam_, 'test_spam (tok)')
      end; // test_spam_mail_Click

    procedure TForm1.result_listbox_Click(Sender: TObject);
        // -- clicks on an result e-mail : reload and display
      var l_c_mail_filter_result: c_mail_filter_result;
          l_c_test_mail_token_frequency_list: c_hash_table;
      begin
        with result_listbox_ do
        begin
          l_c_mail_filter_result:= c_mail_filter_result(result_listbox_.Items.Objects[ItemIndex]);

          if l_c_mail_filter_result<> Nil
            then
              with l_c_mail_filter_result do
              begin
                result_memo_.Lines.Assign(m_c_probability_list);
                result_memo_.Lines.Insert(0, '');
                result_memo_.Lines.Insert(0, m_name);

                // -- also analyze the mail text
                load_and_display_mail(g_test_path+ m_file_name);

                // -- display token list
                initialize_display(test_token_list_memo_.Lines);
                test_token_list_memo_.Lines.Clear;
                with g_c_bayes_spam_filter do
                begin
                  l_c_test_mail_token_frequency_list:= c_hash_table.create_hash_table('');

                  with c_mail_scanner.create_mail_scanner('', m_token_length_min) do
                  begin
                    f_load_from_file(g_test_path+ m_file_name);

                    if m_e_mail_scanning
                      then _add_e_mail_file_tokens(f_c_self, l_c_test_mail_token_frequency_list, True)
                      else _add_raw_tokens(f_c_self, l_c_test_mail_token_frequency_list, True);

                    Free;
                  end; // with c_mail_scanner

                  with l_c_test_mail_token_frequency_list do
                  begin
                    display(Format('len txt %7d  html %7d ', [m_token_length, m_html_token_length]));
                    display_line;
                    display_hash_table;

                    test_sorted_token_listbox_.Items.Clear;
                    with c_hash_iterator.create_hash_iterator('', l_c_test_mail_token_frequency_list) do
                    begin
                      while f_move_next do
                        with f_pt_current_hash_data^ do
                          test_sorted_token_listbox_.Items.Add(Format('%-35s  %6d', [m_hash_string, m_hash_frequency]));

                      Free;
                    end; // with c_hash_iterator.create_hash_iterator

                    Free;
                  end; // with l_c_test_mail_token_frequency_list
                end; // with g_c_bayes_spam_filter
                initialize_display(Memo1.Lines);
              end;
        end; // with result_listbox_
      end; // result_listbox_Click

  end.




