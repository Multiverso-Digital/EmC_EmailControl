// 002 u_c_mail_parser
// 25 mar 2008

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_c_mail_parser;
  interface
    uses Classes, u_c_basic_object
        ;

    type c_mail_parser=
           class(c_basic_object)
             m_from, m_to, m_subject, m_date: String;

             m_text_content, m_html_content: String;

             m_c_mime_content_type_list: tStringList;

             Constructor create_mail_parser(p_name, p_full_file_name: String);
             procedure analyze_mail(p_full_file_name: String);
             Destructor Destroy; Override;
           end; // c_mail_parser

  implementation
    uses SysUtils, Math, u_types_constants, u_c_display, u_characters, u_strings;

    // -- c_mail_parser

    Constructor c_mail_parser.create_mail_parser(p_name, p_full_file_name: String);
      begin
        Inherited create_basic_object(p_name);
        m_c_mime_content_type_list:= tStringList.Create;

        analyze_mail(p_full_file_name);
      end; // create_mail_parser

    type t_content_type= (e_unknown_content, e_text_content, e_html_content
        , e_skip_content
        , e_application_content, e_image_content
        );

    procedure c_mail_parser.analyze_mail(p_full_file_name: String);
      var l_line_index: Integer;
          l_the_line: String;

          l_content_type_string: String;
          l_content_type: t_content_type;
          l_index: Integer;
      begin
        clear_display;
        display('> analyze_mail');

        with tStringList.Create do
        begin
          LoadFromFile(p_full_file_name);

          // -- header: get everything until hits an empty line
          // --  - known lines are collected
          // --  - remainder goes into m_header

          l_line_index:= 0;
          while l_line_index< Count do
          begin
            l_the_line:= Strings[l_line_index];

            if not f_copy_end_if_start_is_equal_to(l_the_line, 'From: ', m_from) then
            if not f_copy_end_if_start_is_equal_to(l_the_line, 'To: ', m_to) then
            if not f_copy_end_if_start_is_equal_to(l_the_line, 'Subject: ', m_subject) then
            if not f_copy_end_if_start_is_equal_to(l_the_line, 'Date: ', m_date) then
            if Trim(l_the_line)= ''
              then begin
                  Inc(l_line_index);
                  Break;
                end
              else ;// m_header:= m_header+ l_the_line+ k_new_line;

            Inc(l_line_index);
          end; // while l_line_index

          // -- had an empty line
          // -- skip all the following empty lines
          while l_line_index< Count do
          begin
            l_the_line:= Strings[l_line_index];

            if Trim(l_the_line)<> ''
              then Break
              else Inc(l_line_index);
          end; // while

          // -- after the first empty line group, put everything into the content

          display_line;
          m_text_content:= '';
          m_html_content:= '';
          l_content_type:= e_unknown_content;

          while l_line_index< Count do
          begin
            l_the_line:= Strings[l_line_index];

            if (Pos('This is a multi-part message in MIME format.', l_the_line)> 0)
                or (Pos('NextPart', l_the_line)> 0)
              then Inc(l_line_index)
              else begin
                  if f_start_is_equal_to(l_the_line, 'Content-Type: ')
                    then begin
                        l_content_type_string:= l_the_line;
                        System.Delete(l_content_type_string, 1, Length('Content-Type: '));
                        l_index:= 1;
                        l_content_type_string:= f_string_extract_until(l_content_type_string, ';', l_index);

                        m_c_mime_content_type_list.Add(l_content_type_string);

                        if f_start_is_equal_to(l_content_type_string, 'application')
                          then l_content_type:= e_application_content else
                        if f_start_is_equal_to(l_content_type_string, 'image')
                          then l_content_type:= e_image_content else
                        if l_content_type_string= 'text/plain'
                          then l_content_type:= e_text_content else
                        if l_content_type_string= 'text/html'
                          then l_content_type:= e_html_content else
                        if l_content_type_string= 'multipart/alternative'
                          then l_content_type:= e_skip_content
                          ;

                        // -- skip until empty line
                        repeat
                          Inc(l_line_index);
                          if l_line_index>= Count
                            then Break;
                          l_the_line:= Strings[l_line_index];
                        until Trim(l_the_line)= '';
                      end
                    else
                      case l_content_type of
                        e_text_content, e_unknown_content:
                            begin
                              m_text_content:= m_text_content+ l_the_line+ k_new_line;
                            end;
                        e_html_content :
                            begin
                              m_html_content:= m_html_content+ l_the_line+ k_new_line;
                            end;
                        e_skip_content, e_application_content : ;
                        Else Break;
                      end; // case l_content_type
                  Inc(l_line_index);
                end; // not Content-Type
          end; // while

          Free;
        end; // with tStringList.Create
        display('< analyze_mail');
      end; // analyze_mail

    Destructor c_mail_parser.Destroy;
      begin
        m_c_mime_content_type_list.Free;

        Inherited;
      end; // Destroy

    begin // u_c_mail_parser
    end. // u_c_mail_parser


