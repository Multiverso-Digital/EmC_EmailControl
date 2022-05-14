// 023 u_strings
// 25 mar 2008

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_strings;
  interface
    uses u_types_constants, u_characters;

    type t_string_4= String[4];
         t_string_5= String[5];
         t_string_6= String[6];
         t_string_8= String[8];
         t_string_19= String[19];

    function f_replace_character(Const pk_string: string; p_original, p_replacement: char): string;

    function f_ansi(p_oem: String): String;
    function f_oem(p_ansi: String): String;
    procedure change_windows_character_to_dos(var pv_character: Char);
    procedure change_dos_character_to_windows(var pv_character: Char);
    procedure transliterate_string_to_dos(var pv_string: String);
    procedure transliterate_string_to_windows(var pv_string: String);

    function f_replace_character_set(p_string: string; p_original_set: t_set_of_characters; p_replacement: char): string;
    function f_replace_character_set_not_in(p_string: string; p_original_set: t_set_of_characters; p_replacement: char): string;

    function f_extract_string(const pk_string: String; p_start, p_end: Integer): String;
    function f_extract_string_and_check(const pk_string: String; p_start, p_end: Integer; var pv_result: String): Boolean;
    function f_extract_integer(const pk_string: String; p_start, p_end: Integer): Integer;

    function f_string_extract_until(p_text: String; p_delimiter: Char; var pv_index: Integer): String;
    function f_string_extract_until_in(p_text: String;
        p_delimiter_set: t_set_of_characters; var pv_index: Integer): String;
    function f_string_extract_characters_not_in(p_string: String; var pv_index: Integer;
        p_accept_set: t_set_of_characters): String;
    function f_string_extract_characters_in(p_string: String; var pv_index: Integer;
        p_accept_set: t_set_of_characters): String;

    procedure skip_blanks(p_string: String; var pv_index: Integer);

    function f_skip_spaces(p_string: String; p_index: Integer): Integer;
    procedure skip_characters_in(p_string: String; p_skip_character_set: t_set_of_characters;
        var pv_index: Integer);

    function f_string_extract_non_blank(p_string: String; var pv_index: Integer): String;
    function f_string_extract_integer(p_string: String; var pv_index: Integer): Integer;
    function f_string_extract_identifier(p_string: String; var pv_index: Integer): String;
    function f_string_extract_quoted_string(p_string: String; var pv_index: Integer): String;
    function f_string_extract_pascal_identifier(p_string: String; var pv_index: Integer): String;
    function f_string_extract_character(p_string: String; var pv_index: Integer): Char;
    function f_copy_end_if_start_is_equal_to(p_string, p_start_text: String; var pv_end: String): Boolean;

    function f_start_is_equal_to(p_string, p_start_text: String): Boolean;
    function f_remove_start_if_start_is_equal_to(p_string, p_start: String): String;
    function f_remove_end_if_end_is_equal_to(p_string, p_end: String): String;
    function f_remove_start(p_string, p_start: String): String;

    function f_copy_end(p_string, p_end_text: String): String;
    function f_end_is_equal_to(p_string, p_end_text: String): Boolean;

    function f_string_max(Const pk_string: String; p_max: Integer): String;

    // -- accounting
    function f_remove_trailing_0(const pk_account: String): String;
    function f_append_with_0(pk_account: String; p_size: Integer): String;

    function f_string_to_char(p_string: String; p_default: Char): Char;
      // because incompat btw some string param and char
    function f_change_returns_in_spaces(p_string: String): String;
    function f_remove_double_spaces(p_string: String): String;

    function f_contains_only(p_string: String; p_set_of_characters: t_set_of_characters): Boolean;

    function f_spaces(p_indente: Integer): String;
    function f_characters(p_indente: Integer; p_character: Char): String;

    function f_starting_space_count(p_string: String): Integer;

    function f_boolean(p_boolean: Boolean; p_boolean_true, p_boolean_false: String): String;
    function f_display_TF(p_boolean: Boolean): String;
    function f_ascii_character_name(p_character: Char): String;
    function f_display_string(p_string: String): String;

    function f_format_string(p_string: String; p_start_column, p_indentation, p_column_max: Integer): String;

    function f_string_extract_comma_separated(p_string: String; var pv_index: Integer): String;
    procedure save_string(p_string: String; p_file_name: String);
    function f_display_k(p_columns, p_value: Integer): String;
    function f_character_count(p_string: String; p_character: Char): Integer;
    function f_replace_return_with_bar(p_string: String): String;
    function f_replace_percent_nn(p_string: String): String;
    function f_change_to_identifier_string(p_string: String): String;
    function f_string_extract_pascal_string(p_string: String; var pv_index: Integer): String;

    function f_unquoted_string(p_string: String): String;
    function f_remove_quote(p_string: String; p_quote: Char): String;
    function f_remove_all_quotes(p_string: String; p_quote: Char): String;

    function f_add_return_line_feed(p_string: String): String;

    function f_indent_new_lines(p_string: String; p_indentation: Integer): String;
    function f_string_vicinity(p_string: String; p_index, p_count: Integer): String;

    function f_remove_starting_blanks_returns(p_string: String): String;
    function f_remove_ending_blanks(p_string: String): String;
    function f_remove_ending_blanks_returns(p_string: String): String;
    function f_remove_starting_ending_blanks_returns(p_string: String): String;

    function f_load_string(p_full_file_name: String): String;

  implementation
    uses Windows, Classes, SysUtils, Math, u_c_display;

    // -- oem / ansi

    function f_ansi(p_oem: String): String;
      const k_buffer_max= 1024;
      var l_buffer: array[0..k_buffer_max] of Char;
          l_pt_buffer_z: pChar;
      begin
        if Length(p_oem)> k_buffer_max
          then begin
              display_bug_stop('*** p_oem, too big');
              Result:= p_oem;
            end
          else begin
              l_pt_buffer_z:= @ l_buffer;
              // AnsiToOem(pChar(p_oem), l_pt_buffer_z);
              OemToAnsi(pChar(p_oem), l_pt_buffer_z);
              Result:= l_pt_buffer_z;
            end;
      end; // f_ansi

    function f_oem(p_ansi: String): String;
(*
      const k_buffer_max= 1024;
      var l_buffer: array[0..k_buffer_max] of Char;
          l_pt_buffer_z: pChar;
*)
      begin
        Result:= p_ansi;
        transliterate_string_to_dos(Result);
(*
        display_bug_stop('*** f_oem does not work (Perez)');
        if Length(p_ansi)> k_buffer_max
          then begin
              display_bug_stop('*** p_ansi, too big');
              Result:= p_ansi;
            end
          else begin
              l_pt_buffer_z:= @ l_buffer;
              AnsiToOem(pChar(p_ansi), l_pt_buffer_z);
              // OemToAnsi(pChar(p_ansi), l_pt_buffer_z);
              Result:= l_pt_buffer_z;
            end;
*)
      end; // f_oem

    procedure change_windows_character_to_dos(var pv_character: Char);
      begin
        case pv_character of
          Chr($E0) : pv_character:= Chr($85);
          Chr($E2) : pv_character:= Chr($83);

          Chr($E7) : pv_character:= Chr($87);

          Chr($E9) : pv_character:= Chr($82);
          Chr($E8) : pv_character:= Chr($8A);
          Chr($EA) : pv_character:= Chr($88);

          Chr($EE) : pv_character:= Chr($8C);

          Chr($F4) : pv_character:= Chr($93);

          Chr($F9) : pv_character:= Chr($97);
          Chr($FB) : pv_character:= Chr($96);
        end; // case
      end; // change_windows_character_to_dos

    procedure change_dos_character_to_windows(var pv_character: Char);
      begin
        case pv_character of
          Chr($85) : pv_character:= Chr($E0);
          Chr($83) : pv_character:= Chr($E2);

          Chr($87) : pv_character:= Chr($E7);

          Chr($82) : pv_character:= Chr($E9);
          Chr($8A) : pv_character:= Chr($E8);
          Chr($88) : pv_character:= Chr($EA);

          Chr($8C) : pv_character:= Chr($EE);

          Chr($93) : pv_character:= Chr($F4);

          Chr($97) : pv_character:= Chr($F9);
          Chr($96) : pv_character:= Chr($FB);
        end; // case
      end; // change_dos_character_to_windows

    procedure transliterate_string_to_dos(var pv_string: String);
      var l_index: Integer;
      begin
        for l_index:= 1 to Length(pv_string) do
          change_windows_character_to_dos(pv_string[l_index]);
      end; // transliterate_string_to_dos

    procedure transliterate_string_to_windows(var pv_string: String);
      var l_index: Integer;
      begin
        for l_index:= 1 to Length(pv_string) do
          change_dos_character_to_windows(pv_string[l_index]);
      end; // transliterate_string_to_windows

    // -- replace

    function f_replace_character(Const pk_string: string; p_original, p_replacement: char): string;
      var l_indice: Integer;
      begin
        Result:= pk_string;
        for l_indice:= 1 to Length(Result) do
          if Result[l_indice]= p_original
            then Result[l_indice]:= p_replacement;
      end; // f_replace_character

    function f_replace_character_set(p_string: string; p_original_set: t_set_of_characters; p_replacement: char): string;
      var l_index: Integer;
      begin
        Result:= p_string;
        for l_index:= 1 to Length(Result) do
          if Result[l_index] in p_original_set
            then Result[l_index]:= p_replacement;
      end; // f_replace_character_set

    function f_replace_character_set_not_in(p_string: string; p_original_set: t_set_of_characters; p_replacement: char): string;
      var l_index: Integer;
      begin
        Result:= p_string;
        for l_index:= 1 to Length(Result) do
          if not (Result[l_index] in p_original_set)
            then Result[l_index]:= p_replacement;
      end; // f_replace_character_set_not_in

    function f_extract_string(const pk_string: String; p_start, p_end: Integer): String;
      var l_length: Integer;
      begin
        l_length:= p_end+ 1- p_start;
        if l_length= 0
          then Result:= ''
          else begin
              SetLength(Result, l_length);
              Move(pk_string[p_start], Result[1], l_length);
            end;
      end; // f_extract_string

    function f_extract_string_and_check(const pk_string: String; p_start, p_end: Integer; var pv_result: String): Boolean;
        // -- extract checking that the indexes are withing the string index ranges
        // -- if ok, extracts, result true
        // -- if range check error, pv_result is the ix display, and Result= false
      var l_string_length, l_length: Integer;
      begin
        l_string_length:= Length(pk_string);
        l_length:= p_end+ 1- p_start;
        Result:= False;

        if p_start<= 0
          then pv_result:= 'ix start='+ IntToStr(p_start)
          else
            if p_end> l_string_length
              then pv_result:= 'ix end='+ IntToStr(p_end)+ '> '+ IntToStr(l_string_length)
              else
                if l_length< 0
                  then pv_result:= 'len '+ IntToStr(p_start)+ '..'+ IntToStr(p_end)
                  else
                    if p_start+ l_length- 1> l_string_length
                      then pv_result:= 'ix '+ IntToStr(p_start)+ '..'+ IntToStr(p_end)
                           + '> '+ IntToStr(l_string_length)
                      else begin
                          if l_length= 0
                            then pv_result:= ''
                            else begin
                                SetLength(pv_result, l_length);
                                Move(pk_string[p_start], pv_result[1], l_length);
                              end;
                          Result:= True;
                        end;

        if not result
          then pv_result:= pv_result+ ' >'+ pk_string+ '<';
      end; // f_extract_string_and_check

    function f_skip_spaces(p_string: String; p_index: Integer): Integer;
      begin
        // display(' >'+ p_string+ '< '+ IntToStr(p_index)+ ' '+ IntToStr(Length(p_string)));
        Result:= p_index;

        While (Result<= Length(p_string)) and (p_string[Result]= ' ') do
          Inc(Result);
      end; // f_skip_spaces

    procedure skip_blanks(p_string: String; var pv_index: Integer);
      begin
        While (pv_index<= Length(p_string)) and (p_string[pv_index] in k_blanks) do
          Inc(pv_index);
      end; // skip_spaces

    procedure skip_characters_in(p_string: String; p_skip_character_set: t_set_of_characters;
        var pv_index: Integer);
      begin
        While (pv_index<= Length(p_string)) and (p_string[pv_index] in p_skip_character_set) do
          Inc(pv_index);
      end; // skip_characters_in

    function f_string_extract_non_blank(p_string: String; var pv_index: Integer): String;
      var l_start_index: Integer;
      begin
        pv_index:= f_skip_spaces(p_string, pv_index);
        l_start_index:= pv_index;
        while (pv_index<= Length(p_string)) and not (p_string[pv_index] in k_blanks) do
          Inc(pv_index);

        Result:= f_extract_string(p_string, l_start_index, pv_index- 1)
      end; // f_string_extract_non_blank

    function f_string_extract_integer(p_string: String; var pv_index: Integer): Integer;
      var l_non_blank: String;
      begin
        l_non_blank:= f_string_extract_non_blank(p_string, pv_index);
        Result:= StrToInt(l_non_blank);
      end; // f_string_extract_integer

    function f_string_extract_identifier(p_string: String; var pv_index: Integer): String;
      var l_start_index: Integer;
      begin
        pv_index:= f_skip_spaces(p_string, pv_index);

        l_start_index:= pv_index;
        while (pv_index<= Length(p_string)) and (p_string[pv_index] in (k_letters+ k_digits+ ['_'])) do
          Inc(pv_index);

        Result:= f_extract_string(p_string, l_start_index, pv_index- 1)
      end; // f_string_extract_identifier

    function f_string_extract_quoted_string(p_string: String; var pv_index: Integer): String;
      var l_start_index: Integer;
      begin
        pv_index:= f_skip_spaces(p_string, pv_index);

        if (pv_index+ 1<= Length(p_string)) and (p_string[pv_index]= '"')
          then begin
              Inc(pv_index);
              l_start_index:= pv_index;
              while (pv_index<= Length(p_string)) and (p_string[pv_index]<> '"') do
                Inc(pv_index);

              Result:= f_extract_string(p_string, l_start_index, pv_index- 1);
              Inc(pv_index);
            end
          else Result:= '';
      end; // f_string_extract_quoted_string

    function f_string_extract_until(p_text: String; p_delimiter: Char; var pv_index: Integer): String;
      begin
        Result:= '';
        while (pv_index<= Length(p_text)) and (p_text[pv_index]<> p_delimiter) do
        begin
          Result:= Result+ p_text[pv_index];
          Inc(pv_index);
        end;
      end; // f_string_extract_until

    function f_string_extract_until_in(p_text: String;
          p_delimiter_set: t_set_of_characters; var pv_index: Integer): String;
        // -- mainly for eol terminated strings
      begin
        Result:= '';
        while (pv_index<= Length(p_text)) and not (p_text[pv_index] in p_delimiter_set) do
        begin
          Result:= Result+ p_text[pv_index];
          Inc(pv_index);
        end;
      end; // f_string_extract_until_in

    function f_string_extract_characters_in(p_string: String; var pv_index: Integer;
        p_accept_set: t_set_of_characters): String;
      var l_start_index: Integer;
      begin
        pv_index:= f_skip_spaces(p_string, pv_index);
        l_start_index:= pv_index;
        // -- mod 21 oct 2003 <= length
        while (pv_index<= Length(p_string)) and (p_string[pv_index] in p_accept_set) do
          Inc(pv_index);

        Result:= f_extract_string(p_string, l_start_index, pv_index- 1)
      end; // f_string_extract_characters_in

    function f_string_extract_character(p_string: String; var pv_index: Integer): Char;
      begin
        result:= p_string[pv_index];
        Inc(pv_index);
      end; // f_string_extract_character_in

    function f_string_extract_pascal_identifier(p_string: String; var pv_index: Integer): String;
        // -- not true identifier: should check first character, then [alpha_num, _]
        // --   this "search first alpha, then ["_", alpha_num]
      var l_start_index: Integer;
      begin
        // -- skip all non ['_', alpha]
        while (pv_index<= Length(p_string)) and not (p_string[pv_index] in (k_letters+ ['_'])) do
          Inc(pv_index);

        l_start_index:= pv_index;
        while (pv_index<= Length(p_string)) and (p_string[pv_index] in (k_letters+ k_digits+ ['_'])) do
          Inc(pv_index);

        Result:= f_extract_string(p_string, l_start_index, pv_index- 1)
      end; // f_string_extract_pascal_identifier

    function f_string_extract_pascal_string(p_string: String; var pv_index: Integer): String;
      var l_start_index, l_length: Integer;
      begin
        skip_blanks(p_string, pv_index);

        l_length:= Length(p_string);
        l_start_index:= pv_index;
        // -- todo: check '

        // display('> f_string_extract_pascal_string');

        repeat
          repeat
            inc(pv_index);
          until (pv_index> l_length) or (p_string[pv_index]= '''');

          // -- here on last ' or intermediate double '

          // -- if on ', is after the string, if on '', skip the second
          inc(pv_index);
        until (pv_index> l_length) or (p_string[pv_index]<> '''');
        // display('< f_string_extract_pascal_string');

        // -- here after last '

        if pv_index- 1> l_start_index
          then Result:= f_extract_string(p_string, l_start_index, pv_index- 1)
          else Result:= '';
      end; // f_string_extract_pascal_string

    function f_copy_end(p_string, p_end_text: String): String;
       // -- extract ".html" from "livres.html"
      var l_length_string, l_length_end: Integer;
      begin
        l_length_string:= Length(p_string);
        l_length_end:= Length(p_end_text);
        if (l_length_string> 0) and (l_length_end> 0)
          then Result:= Copy(p_string, l_length_string- l_length_end+ 1, l_length_end)
          else Result:= '';
      end; // f_copy_end

    function f_start_is_equal_to(p_string, p_start_text: String): Boolean;
      begin
        Result:= Copy(p_string, 1, Length(p_start_text))= p_start_text;
      end; // f_start_is_equal_to

    function f_remove_start_if_start_is_equal_to(p_string, p_start: String): String;
      begin
        if f_start_is_equal_to(p_string, p_start)
          then Result:= Copy(p_string, Length(p_start)+ 1, Length(p_string)- Length(p_start))
          else Result:= p_string;
      end; // f_remove_end_if_end_is_equal_to

    function f_remove_start(p_string, p_start: String): String;
      begin
        Result:= Copy(p_string, Length(p_start)+ 1, Length(p_string)- Length(p_start))
      end; // f_remove_start  

    function f_end_is_equal_to(p_string, p_end_text: String): Boolean;
      begin
        Result:= f_copy_end(p_string, p_end_text)= p_end_text;
      end; // f_end_is_equal_to

    function f_remove_end_if_end_is_equal_to(p_string, p_end: String): String;
      begin
        if f_end_is_equal_to(p_string, p_end)
          then Result:= Copy(p_string, 1, Length(p_string)- Length(p_end))
          else Result:= p_string;
      end; // f_remove_end_if_end_is_equal_to

    function f_extract_integer(const pk_string: String; p_start, p_end: Integer): Integer;
      begin
        Result:= StrToInt(f_extract_string(pk_string, p_start, p_end));
      end; // f_extract_integer

    function f_string_max(Const pk_string: String; p_max: Integer): String;
      var l_size: Integer;
      begin
        l_size:= Length(pk_string);
        if l_size> p_max
          then Result:= Copy(pk_string, 1, p_max)
          else Result:= pk_string+ f_spaces(p_max- l_size);
      end; // f_string_max

    function f_copy_end_if_start_is_equal_to(p_string, p_start_text: String; var pv_end: String): Boolean;
      begin
        if f_start_is_equal_to(p_string, p_start_text)
          then begin
              Result:= true;
              pv_end:= p_string;
              Delete(pv_end, 1, Length(p_start_text));
              // display('ok >'+ pv_end+ '<');
            end
          else begin
              // display('  no '+ p_start_text);
              Result:= False;
              // pv_end:= '';
            end;
      end; // f_copy_end_if_start_is_equal_to

    function f_change_returns_in_spaces(p_string: String): String;
      var l_index: Integer;
      begin
        Result:= p_string;

        For l_index:= 1 to Length(Result) do
          if (Result[l_index]= k_return) or (Result[l_index]= k_line_feed)
            then Result[l_index]:= ' ';
      end; // f_change_returns_in_spaces

    function f_remove_double_spaces(p_string: String): String;
      var l_index: Integer;
      begin
        Result:= '';
        l_index:= 1;
        while l_index<= Length(p_string) do
        begin
          if p_string[l_index]= ' '
            then begin
                Result:= Result+ p_string[l_index];
                Inc(l_index);
                while (l_index<= Length(p_string)) and (p_string[l_index]= ' ') do
                  Inc(l_index);
              end
            else begin
                Result:= Result+ p_string[l_index];
                Inc(l_index);
              end;
        end;
      end; // f_remove_double_spaces

    function f_remove_trailing_0(const pk_account: String): String;
      var l_index: Integer;
      begin
        Result:= pk_account;
        l_index:= Length(Result);
        while (l_index>= 1) and (Result[l_index]= '0') do
        begin
          Delete(Result, l_index, 1);
          Dec(l_index);
        end;

        // if Result<> pk_account
        //   then display(pk_account+ ' -> '+ Result);
      end; // f_remove_trailing_0

    function f_append_with_0(pk_account: String; p_size: Integer): String;
      var l_index: Integer;
      begin
        Result:= pk_account;
        for l_index:= Length(pk_account)+ 1 to p_size do
          Result:= Result+ '0';
      end; // f_append_with_0

    function f_string_to_char(p_string: String; p_default: Char): Char;
      begin
        if p_string= ''
          then Result:= p_default
          else Result:= p_string[1];
      end; // f_string_to_char

    function f_contains_only(p_string: String; p_set_of_characters: t_set_of_characters): Boolean;
      var l_index: Integer;
      begin
        Result:= False;
        for l_index:= 1 to Length(p_string) do
          if not (p_string[l_index] in p_set_of_characters)
            Then Exit;

        Result:= True;
      end; // f_contains_only

    function f_spaces(p_indente: Integer): String;
      var l_indice: Integer;
      begin
        SetLength(Result, p_indente);
        for l_indice:= 1 to p_indente do
          Result[l_indice]:= ' ';
      end; // f_spaces

    function f_characters(p_indente: Integer; p_character: Char): String;
      begin
        Result:= f_spaces(p_indente);
        if p_indente> 0
          then FillChar(Result[1], p_indente, p_character);
      end; // f_characters

    function f_boolean(p_boolean: Boolean; p_boolean_true, p_boolean_false: String): String;
      begin
        if p_boolean
          then Result:= p_boolean_true
          else Result:= p_boolean_false;
      end; // f_boolean

    function f_display_TF(p_boolean: Boolean): String;
      begin
        if p_boolean
          then Result:= 'T'
          else Result:= 'F';
      end; // f_display_TF

    function f_starting_space_count(p_string: String): Integer;
      var l_index: Integer;
      begin
        l_index:= 1;
        while (l_index<= Length(p_string)) and (p_string[l_index]= ' ') do
          Inc(l_index);
        Result:= l_index- 1;
      end; // f_starting_space_count

    function f_ascii_character_name(p_character: Char): String;
      begin
        case p_character of
          #8: Result:= 'Del';
          #9: Result:= 'Tab';
          #10 : Result:= 'Lf';
          #13: Result:= 'Return';
          #27: Result:= 'Esc';

          #0..#7, #11..#12, #14..#26, #28..#31: Result:= IntToStr(Ord(
                  p_character));
          else Result:= p_character;
        end;
      end; // f_ascii_character_name

    function f_display_string(p_string: String): String;
      var l_index: Integer;
      begin
        Result:= '';
        for l_index:= 1 to Length(p_string) do
          Result:= Result+ f_ascii_character_name(p_string[l_index]);
      end; // f_display_string

    function f_format_string(p_string: String; p_start_column, p_indentation, p_column_max: Integer): String;
        // -- format xxxxxx into
        // --  -----xx xx |
        // --  ==xx xxxxx |
        // --  ==xxxx xxx |
        // -- the first words are APPENDED to an already existing string
      var l_line_length: Integer;
          l_word: String;

      procedure add_word;
        var l_word_length: Integer;
        begin
          l_word_length:= Length(l_word);
          if l_line_length+ 1+ l_word_length> p_column_max
            then begin
                // -- needs to change the line
                Result:= Result+ k_new_line;
                // -- place the word
                Result:= Result+ f_spaces(p_indentation)+ l_word;
                l_line_length:= p_indentation+ l_word_length;
              end
            else begin
                // -- add to the previous
                if Trim(Result)= ''
                  then Result:= l_word
                  else Result:= Result+ ' '+ l_word;
                Inc(l_line_length, l_word_length+ 1);
              end;
          l_word:= '';
        end; // add_word

      var l_index: Integer;

      begin // f_format_string
        Result:= '';
        l_word:= '';
        // display(p_string);
        l_line_length:= p_start_column;
        for l_index:= 1 to Length(p_string) do
        begin
          if p_string[l_index]= ' '
            then add_word
            else l_word:= l_word+ p_string[l_index];
        end; // for

        // -- the last word
        add_word;
      end; // f_format_string

    function f_string_extract_comma_separated(p_string: String; var pv_index: Integer): String;
        // -- trims the result
      var l_start_index: Integer;
      begin
        // -- NO: if glued together xxx,yyy, does not isolate xxx
        // Result:= f_string_extract_non_blank(p_string, pv_index);

        // pv_index:= f_skip_spaces(p_string, pv_index);
        l_start_index:= pv_index;
        while (pv_index<= Length(p_string)) and (p_string[pv_index]<> ',') do
          Inc(pv_index);

        Result:= Trim(f_extract_string(p_string, l_start_index, pv_index- 1));
        // -- get beyond the separator
        Inc(pv_index);
      end; // f_string_extract_comma_separated

    procedure save_string(p_string: String; p_file_name: String);
        // -- TODO use a FILE !
      begin
        with tStringList.Create do
        begin
          Text:= p_string;
          SaveToFile(p_file_name);
          Free;
        end;
      end; // save_string

    function f_display_k(p_columns, p_value: Integer): String;
      begin
        Result:= Format('%'+ IntToStr(p_columns)+ '.0n K', [1.0* p_value/ 1024]);
      end; // f_display_k

    function f_character_count(p_string: String; p_character: Char): Integer;
      var l_index: Integer;
      begin
        Result:= 0;
        for l_index:= 1 to Length(p_string) do
          if p_string[l_index]= p_character
            then Inc(Result);
      end; // f_character_count

    function f_replace_return_with_bar(p_string: String): String;
      var l_index: Integer;
          l_character: Char;
      begin
        Result:= '';
        for l_index:= 1 to Length(p_string) do
        begin
          l_character:= p_string[l_index];
          case l_character of
            k_return : Result:= Result+ '|';
            k_line_feed : Result:= Result+ '|';
            else
              Result:= Result+ l_character;
          end; // case
        end; // for l_index
      end; // f_replace_return_with_bar

    function f_replace_percent_nn(p_string: String): String;
      var l_index, l_length: Integer;
          l_ord: Integer;
          l_character: Char;
      begin
        l_index:= 1; l_length:= Length(p_string);
        Result:= p_string;
        while l_index+ 2<= l_length do
        begin
          if (Result[l_index]= '%')
              and (UpCase(Result[l_index+ 1]) in k_upper_hex_digits)
              and (UpCase(Result[l_index+ 2]) in k_upper_hex_digits)
            then begin
                l_ord:= StrToInt('$'+ Result[l_index+ 1]+ Result[l_index+ 2]);
                l_character:= Chr(l_ord);
                Result[l_index]:= l_character;
                Delete(Result, l_index+ 1, 2);
                Dec(l_length, 2);
              end;
          Inc(l_index);
        end; // while l_index
      end; // f_replace_percent_nn

    function f_change_to_identifier_string(p_string: String): String;
        // -- replace all "non a..z A..Z 0..9 _" into _
        // --   if empty => "a"
        // --   if starts with a digit => prepend "a"
      var l_index: Integer;
      begin
        Result:= p_string;

        if Length(Result)= 0
          then Result:= 'a'
          else
            if Result[1] in k_digits
              then Result:= 'a'+ Result;;

        For l_index:= 1 to Length(Result) do
          if not (Result[l_index] in k_pascal_identifier_middle)
            then Result[l_index]:= '_';
      end; // f_change_to_identifier_string

    function f_unquoted_string(p_string: String): String;
        // -- remove the surrounding single quotes
        // -- if no surrounding quotes, do nothing
      begin
        Result:= p_string;
        // -- sanity
        if (Length(Result)>= 2)
            and (Result[1]= '''') and (Result[Length(Result)]= '''')
          then begin
              Delete(Result, 1, 1);
              Delete(Result, Length(Result), 1);
            end
      end; // f_unquoted_string

    function f_remove_quote(p_string: String; p_quote: Char): String;
        // -- remove the surrounding quotes
        // -- if no surrounding quotes, do nothing
      begin
        Result:= p_string;
        // -- sanity
        if (Length(Result)>= 2)
            and (Result[1]= p_quote) and (Result[Length(Result)]= p_quote)
          then begin
              Delete(Result, 1, 1);
              Delete(Result, Length(Result), 1);
            end
      end; // f_remove_quote

    function f_remove_all_quotes(p_string: String; p_quote: Char): String;
      var l_index, l_length: Integer;
      begin
        Result:= p_string;
        l_index:= 1; l_length:= Length(Result);
        while l_index<= l_length do
        begin
          if Result[l_index]= p_quote
            then begin
                Delete(Result, l_index, 1);
                Dec(l_length);
              end
            else Inc(l_index);
        end; // while l_index
      end; // f_remove_all_quotes

    function f_string_extract_characters_not_in(p_string: String; var pv_index: Integer;
        p_accept_set: t_set_of_characters): String;
      var l_start_index: Integer;
      begin
        pv_index:= f_skip_spaces(p_string, pv_index);
        l_start_index:= pv_index;
        // -- mod 21 oct 2003 <= length
        while (pv_index<= Length(p_string)) and not (p_string[pv_index] in p_accept_set) do
          Inc(pv_index);

        Result:= f_extract_string(p_string, l_start_index, pv_index- 1)
      end; // f_string_extract_characters_not_in

    function f_add_return_line_feed(p_string: String): String;
      var l_index: Integer;
      begin
        Result:= '';
        l_index:= 1;
        while l_index<= Length(p_string) do
          case p_string[l_index] of
            k_return :
              begin
                Result:= Result+ k_return+ k_line_feed;
                Inc(l_index);
                if (l_index<= Length(p_string)) and (p_string[l_index]= k_line_feed)
                  then Inc(l_index);
              end;
            k_line_feed:
              begin
                Result:= Result+ k_return+ k_line_feed;
                Inc(l_index);
              end;
            else
              Result:= Result+ p_string[l_index];
              Inc(l_index);
          end; // case
      end; // f_add_return_line_feed

    function f_indent_new_lines(p_string: String; p_indentation: Integer): String;
        // -- if new line, adds indentation (?? if not yet there)
        // -- does NOT indent the first line
        // -- if ends with a return, adds indentation to the next line
        // -- does NOT touch to the previous indentation
      var l_index: Integer;
      begin
        Result:= '';
        l_index:= 1;
        while l_index<= Length(p_string) do
        begin
          if p_string[l_index]= k_return
            then begin
                // display('Ret');
                Result:= Result+ k_new_line+ f_spaces(p_indentation);
                Inc(l_index, 2);
              end
            else begin
                Result:= Result+ p_string[l_index];
                Inc(l_index);
              end;
        end;
      end; // f_indent_new_lines

    function f_string_vicinity(p_string: String; p_index, p_count: Integer): String;
      var l_index: Integer;
          l_length: Integer;
      begin
        Result:= '';
        l_length:= Length(p_string);
        if l_length= 0
          then Exit;

        for l_index:= Max(0, p_index- p_count) to Min(Max(0, p_index- 1), l_length) do
          Result:= Result+ p_string[l_index];
        Result:= Result+ '|';
        for l_index:= p_index to Min(p_index+ p_count, l_length) do
          Result:= Result+ p_string[l_index];
      end; // f_string_vicinity

    function f_remove_starting_blanks_returns(p_string: String): String;
      var l_length, l_index: Integer;
      begin
        l_length:= Length(p_string);
        l_index:= 1;
        while (l_index<= l_length) and (p_string[l_index] in [chr(13), chr(10), ' ', chr(9)]) do
          Inc(l_index);

        if l_index> 1
          then Result:= Copy(p_string, l_index, l_length+ 1- l_index)
          else Result:= p_string;
      end; // f_remove_starting_blanks_returns

    function f_remove_ending_blanks(p_string: String): String;
        // -- TrimRight
      var l_length, l_index: Integer;
      begin
        l_length:= Length(p_string);
        l_index:= l_length;
        while (l_index>= 1) and (p_string[l_index] in [' ', chr(9)]) do
          Dec(l_index);

        if l_index< l_length
          then Result:= Copy(p_string, 1, l_index)
          else Result:= p_string;
      end; // f_remove_ending_blanks_

    function f_remove_ending_semi_colon(p_string: String): String;
      var l_length, l_index: Integer;
      begin
        l_length:= Length(p_string);
        l_index:= l_length;
        Result:= p_string;

        while (l_index>= 1) and (p_string[l_index] in [' ', chr(9)]) do
          Dec(l_index);

        if (l_index>= 1) and (p_string[l_index]= ';')
          then Result[l_index]:= ' ';
      end; // f_remove_ending_semi_colon

    function f_remove_ending_blanks_returns(p_string: String): String;
      var l_length, l_index: Integer;
      begin
        l_length:= Length(p_string);
        l_index:= l_length;
        while (l_index>= 1) and (p_string[l_index] in [chr(13), chr(10), ' ', chr(9)]) do
          Dec(l_index);

        if l_index< l_length
          then Result:= Copy(p_string, 1, l_index)
          else Result:= p_string;
      end; // f_remove_ending_blanks_returns

    function f_remove_starting_ending_blanks_returns(p_string: String): String;
      begin
        Result:= f_remove_starting_blanks_returns(f_remove_ending_blanks_returns(p_string));
      end; // f_remove_starting_ending_blanks_returns

    function f_load_string(p_full_file_name: String): String;
      var l_file: File;
          l_length: Integer;
      begin
        AssignFile(l_file, p_full_file_name);
        Reset(l_file, 1);
        l_length:= FileSize(l_file);
        // display(IntToStr(l_length));
        if l_length= 0
          then Result:= ''
          else begin
              SetLength(Result, l_length);
              BlockRead(l_file, Result[1], l_length);
            end;
        Close(l_file);
      end; // f_load_string

  end.

