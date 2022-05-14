// 002 u_c_mail_scanner_4
// 25 mar 2008

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

// -- extract the token, and add the token to an existing c_token_frequency_list

(*$r+*)

unit u_c_mail_scanner_4;
  interface
    uses Classes
        , u_types_constants, u_characters
        , u_c_text_buffer
        ;

    type c_mail_scanner=
             class(c_text_buffer)
               m_token_min: Integer;

               // -- stats
               m_html_character_count: Integer;
               m_line_break_count: Integer;

               constructor create_mail_scanner(p_name: String; p_token_min: Integer);

               function f_c_self: c_mail_scanner;

               function f_token: String;
               function f_mail_token: String;
               destructor Destroy; Override;
             end; // c_mail_scanner

  implementation
    uses SysUtils, Dialogs, Math, u_c_display;

    constructor c_mail_scanner.create_mail_scanner(p_name: String;
        p_token_min: Integer);
      begin
        Inherited create_text_buffer(p_name, 0);
        m_token_min:= p_token_min;
      end; // create_mail_scanner

    function c_mail_scanner.f_c_self: c_mail_scanner;
      begin
        Result:= Self;
      end; // f_c_self

    function c_mail_scanner.f_token: String;
      const k_tokens= ['a'..'z', 'A'..'Z', '0'..'9', '_'];
            k_separators= [#0..#255]- k_tokens+ k_digits;
      var l_start, l_length: Integer;
      begin
        repeat
          // -- skip separators
          while (m_buffer_index< m_buffer_size) and (m_oa_text_buffer[m_buffer_index] in k_separators) do
            inc(m_buffer_index);

          l_start:= m_buffer_index;
          while (m_buffer_index< m_buffer_size) and (m_oa_text_buffer[m_buffer_index] in k_tokens) do
            inc(m_buffer_index);

          l_length:= m_buffer_index- l_start;
          if l_length> m_token_min
            then begin
                SetLength(Result, l_length);
                Move(m_oa_text_buffer[l_start], Result[1], l_length);

                Break;
              end
            else Result:= '';
        until (m_buffer_index>= m_buffer_size);
      end; // add_to_token_list

    function c_mail_scanner.f_mail_token: String;
        // -- accept =xx html characters. But does not translate (the training set
        // --   and the real e-mail are supposed to have them)
        // --   could remove line end =RLF, but necessitates to concatenate strings
      const // -- for accents, should transform .html encoding  ("=E0" etc)
            k_start_tokens= ['a'..'z', 'A'..'Z'];
            k_middle_tokens= k_start_tokens+ ['0'..'9', '_', '-', '='];
            k_separators= [#0..#255]- (k_start_tokens);
      var l_start, l_length: Integer;
          l_first_part_length: Integer;
          l_first_part: String;
          // -- debug
          l_has_split: Boolean;
      begin
        repeat
          // -- skip separators
          while (m_buffer_index< m_buffer_size) and (m_oa_text_buffer[m_buffer_index] in k_separators) do
            inc(m_buffer_index);

          l_start:= m_buffer_index;
          l_first_part_length:= 0;
          l_has_split:= False;
          while (m_buffer_index< m_buffer_size) and (m_oa_text_buffer[m_buffer_index] in k_middle_tokens) do
          begin
            // -- accept xxx=XXXyyy. No need to translate
            if m_oa_text_buffer[m_buffer_index]= '='
              then begin
                  if (m_buffer_index+ 2< m_buffer_size)
                      and (m_oa_text_buffer[m_buffer_index+ 1] in k_hex_digits)
                      and (m_oa_text_buffer[m_buffer_index+ 2] in k_hex_digits)
                    then Inc(m_html_character_count)
                    else
                      if (m_buffer_index+ 2< m_buffer_size)
                          and (m_oa_text_buffer[m_buffer_index+ 1]= k_return)
                          and (m_oa_text_buffer[m_buffer_index+ 2]= k_line_feed)
                        then begin
                            l_has_split:= True;
                            Inc(m_line_break_count);
                            l_first_part_length:= m_buffer_index- l_start;
                            if l_first_part_length> 0
                              then begin
                                  SetLength(l_first_part, l_first_part_length);
                                  Move(m_oa_text_buffer[l_start], l_first_part[1], l_first_part_length);
                                end;

                            // -- skip 2, 3rd will be skipped at the end of the loop
                            Inc(m_buffer_index, 2);
                            // -- word starts after =HH
                            l_start:= m_buffer_index+ 1;
                          end
                        else begin
                            Break;
                          end;
                end;

            inc(m_buffer_index);
          end; // while (m_buffer_index

          l_length:= m_buffer_index- l_start;
          if l_first_part_length+ l_length> m_token_min
            then begin
                if l_length> 0
                  then begin
                      SetLength(Result, l_length);
                      Move(m_oa_text_buffer[l_start], Result[1], l_length);

                      if l_first_part_length> 0
                        then Result:= l_first_part+ Result;
                    end
                  else
                    if l_first_part_length> 0
                      then Result:= l_first_part;
              end
            else Result:= '';
        until (l_first_part_length+ l_length> m_token_min) or (m_buffer_index>= m_buffer_size);
      end; // f_mail_token

    destructor c_mail_scanner.Destroy;
      begin
        Inherited Destroy;
      end; // Destroy

    end. // u_text_file


