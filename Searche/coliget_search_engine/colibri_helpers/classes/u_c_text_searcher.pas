// 002 u_c_text_searcher
// 23 dec 2004

// -- (C) Felix John COLIBRI 2004
// -- documentation: http://www.felix-colibri.com

(*$r+*)

// -- find a string contained in a string
// --  - exits at first occurence

// -- steps:
// --  1 - create
// --  2 - initialize_base_text
// --  3 - initialize_pattern_to_search
// --  4 - f_find_start_index

unit u_c_text_searcher;
  interface
    uses u_c_basic_object;

    type c_text_searcher= class(c_basic_object)
                            m_text_to_search: String;
                            m_text_length: Integer;

                            m_pattern_to_find: String;
                            m_pattern_length: Integer;

                            m_jump_table: array[#0..#255] of Integer;
                            m_jump_value: integer;

                            m_search_index: Integer;
                            m_display_search: Boolean;

                            Constructor create_text_searcher(p_name: String);

                            procedure initialize_text(p_text_to_search: String);
                            procedure initialize_pattern_to_search(p_pattern_to_search: String);
                            function f_index_of: Integer;

                            function f_found_string(p_pattern_to_search: String): Boolean;
                            function f_found_string_in_text(p_pattern_to_search, p_text_to_search: String): Boolean;

                            Destructor Destroy; Override;
                          end; // c_text_searcher

  implementation
    uses SysUtils, u_c_display
        , u_strings
        ;

    // -- c_text_searcher

    Constructor c_text_searcher.create_text_searcher(p_name: String);
      begin
        Inherited create_basic_object(p_name);
      end; // create_text_searcher

    procedure c_text_searcher.initialize_text(p_text_to_search: String);
      begin
        m_text_to_search:= p_text_to_search;
        m_text_length:= Length(p_text_to_search);
        m_search_index:= 1;
      end; // initialize_text

    procedure c_text_searcher.initialize_pattern_to_search(p_pattern_to_search: String);
      var l_character_code: char;
          l_pattern_index: integer;
      begin
        FillChar(m_jump_table, SizeOf(m_jump_table), 0);

        m_pattern_to_find:= p_pattern_to_search;
        m_pattern_length:= length(m_pattern_to_find);
        if m_pattern_length= 0
          then exit;

        for l_character_code:= #0 to #255 do
          m_jump_table[l_character_code]:= m_pattern_length;
        for l_pattern_index:= 1 to m_pattern_length- 1 do
          m_jump_table[m_pattern_to_find[l_pattern_index]]:= m_pattern_length- l_pattern_index;
        m_jump_value:= m_jump_table[m_pattern_to_find[m_pattern_length]];
        m_jump_table[m_pattern_to_find[m_pattern_length]]:= 0;
      end; // initialize_pattern_to_search

    function c_text_searcher.f_index_of: Integer;
        // -- returns the index in the STRING
        // -- 0 of not in the string
        // -- can repeat the search: searches from the previouse m_text_index
      // const k_display= False;
      var l_index_of_pattern_character: integer;
          l_pattern_index: Integer;
      begin
        if m_display_search
          then display('> f_index_of start_ix='+ IntToStr(m_search_index));
        Result:= 0;

        // -- because starts at the end
        Inc(m_search_index, m_pattern_length- 1);

        // -- ++: not <=, or not before length of the pattern
        while m_search_index< m_text_length do
        begin
          // -- test last character first
          l_index_of_pattern_character:= m_jump_table[m_text_to_search[m_search_index]];
          if l_index_of_pattern_character<> 0
            then // -- last char does not match
                 inc(m_search_index, l_index_of_pattern_character)
            else begin
                // -- last char matches at least
                // -- so check whether the previous characters match as well
                l_pattern_index:= m_pattern_length- 1;

                while (l_pattern_index> 0)
                    and (m_pattern_to_find[m_pattern_length- l_pattern_index]= m_text_to_search[m_search_index- l_pattern_index]) do
                  dec(l_pattern_index);

                if l_pattern_index<> 0
                  then // -- found a difference in one of the characters
                       Inc(m_search_index, m_jump_value)
                  else
                    begin
                      // -- all characters match
                      // -- return the index of the first character
                      Result:= m_search_index- m_pattern_length+ 1;

                      // -- prepare next search: place the
                      // -- running index after the match
                      inc(m_search_index);
                      if m_display_search
                        then display('< f_index_of OK '+ IntToStr(m_search_index));
                      exit;
                    end;
              end; // last character matched
        end; // while

        if m_display_search
          then display('< f_index_of NO_MORE '+ IntToStr(m_search_index));
      end; // f_index_of

    function c_text_searcher.f_found_string(p_pattern_to_search: String): Boolean;
      begin
        initialize_pattern_to_search(p_pattern_to_search);
        m_search_index:= 1;

        Result:= f_index_of> 0;
      end; // f_found_string

    function c_text_searcher.f_found_string_in_text(p_pattern_to_search, p_text_to_search: String): Boolean;
      begin
        initialize_text(p_text_to_search);
        initialize_pattern_to_search(p_pattern_to_search);
        m_search_index:= 1;

        Result:= f_index_of> 0;
      end; // f_found_string_in_text

    Destructor c_text_searcher.Destroy;
      begin
        Inherited;
      end; // Destroy

    begin

    end.
