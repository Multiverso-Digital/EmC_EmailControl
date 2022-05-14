// 002 u_c_request_evaluator
// 23 dec 2004

// -- (C) Felix John COLIBRI 2004
// -- documentation: http://www.felix-colibri.com

// -- parse the expression, and check whether a text satisfies the condition

(*$r+*)

unit u_c_request_evaluator;
  interface
    uses Classes, u_c_basic_object
        , u_c_text_searcher
      ;

    type c_request_evaluator= class(c_basic_object)
                                m_trace_evaluation: Boolean;

                                m_request: String;
                                m_c_request_identifiers: tStringList;
                                m_oa_tokens: Array Of Integer;
                                // -- for error positionning
                                m_oa_token_positions: Array Of Integer;
                                m_oa_token_lengths: Array Of Integer;

                                m_error_index, m_error_length: Integer;
                                m_error_message: String;

                                Constructor create_request_evaluator(p_name: String);

                                procedure tokenize_request(p_request: String);
                                function f_display_token_type(p_token_type: Integer): String;
                                procedure redisplay_request;

                                function f_evaluate_request(p_c_text_searcher: c_text_searcher): Boolean;

                                Destructor Destroy; Override;
                              end; // Virtual;

  implementation
    uses SysUtils
        , u_strings, u_c_display
        ;

    // -- c_request_evaluator

    Constructor c_request_evaluator.create_request_evaluator(p_name: String);
      begin
        Inherited ;
      end; // create_request_evaluator

    const k_token_NOT= -1;
          k_token_AND= -2;
          k_token_OR= -3;
          k_token_opening_parenthesis= -4;
          k_token_closing_parenthesis= -5;
          k_token_end= -6;

    procedure c_request_evaluator.tokenize_request(p_request: String);
      var l_request_length: Integer;

      const k_start_letters= ['a'..'z', 'A'..'Z'];
            k_letters= k_start_letters+ ['_', '0'..'9'];

      procedure get_identifiers_and_count_tokens;
        var l_request_index: Integer;
            l_token_count: Integer;

        procedure analyze_identifier;
           // -- simply skip the letters
          begin
            while (l_request_index<= l_request_length)
                and (p_request[l_request_index] in k_letters) do
              Inc(l_request_index);

            Inc(l_token_count);
          end; // analyze_identifier

        procedure analyze_litteral_string;
          begin
            // -- skip "
            Inc(l_request_index);

            while (l_request_index<= l_request_length)
                and (p_request[l_request_index]<> '"') do
              Inc(l_request_index);

            // -- skip "
            Inc(l_request_index);

            Inc(l_token_count);
          end; // analyze_litteral_string

        begin // get_identifiers_and_count_tokens
          l_request_index:= 1;
          l_token_count:= 0;

          while l_request_index<= l_request_length do
          begin
            case p_request[l_request_index] of
              'a'..'z', 'A'..'Z',
                '0'..'9' : analyze_identifier;
              ' ' : Inc(l_request_index);
              '(', ')', '.' : begin
                               Inc(l_request_index);
                               Inc(l_token_count);
                             end;
              '"' : analyze_litteral_string;
              else
                // ds display_bug_stop('invalid operator');
                m_error_index:= l_request_index;
                m_error_length:= 1;
                Break;
            end; // case
          end; // while

          // display('token_count '+ IntToStr(l_token_count));

          if m_error_index= 0
            then begin
                SetLength(m_oa_tokens, l_token_count);
                SetLength(m_oa_token_positions, l_token_count);
                SetLength(m_oa_token_lengths, l_token_count);
              end;
        end; // get_identifiers_and_count_tokens

      procedure fill_identifier_list_and_token_array;
        var l_request_index: Integer;
            l_token_count: Integer;

        procedure analyze_identifier;
          var l_start_index, l_identifier_length: Integer;
              l_identifier: String;
              l_index: Integer;
              l_lowercase_identifier: String;
          begin
            l_start_index:= l_request_index;
            while (l_request_index<= l_request_length)
                and (p_request[l_request_index] in k_letters) do
              Inc(l_request_index);

            l_identifier_length:= l_request_index- l_start_index;
            SetLength(l_identifier, l_identifier_length);
            Move(p_request[l_start_index], l_identifier[1], l_identifier_length);

            l_lowercase_identifier:= LowerCase(l_identifier);

            // -- check whether this is AND OR NOT
            if l_lowercase_identifier= 'and'
              then m_oa_tokens[l_token_count]:= k_token_AND
                else
                  if l_lowercase_identifier= 'or'
                    then m_oa_tokens[l_token_count]:= k_token_OR
                      else
                        if l_lowercase_identifier= 'not'
                          then m_oa_tokens[l_token_count]:= k_token_NOT
                          else begin
                              // -- the identifier
                              l_index:= m_c_request_identifiers.Add(l_lowercase_identifier);
                              m_oa_tokens[l_token_count]:= l_index;
                            end;
            m_oa_token_positions[l_token_count]:= l_start_index;
            m_oa_token_lengths[l_token_count]:= l_identifier_length;

            Inc(l_token_count);
          end; // analyze_identifier

        procedure analyze_litteral_string;
          var l_start_index, l_identifier_length: Integer;
              l_identifier, l_lowercase_identifier: String;
              l_index: Integer;
          begin
            // -- skip "
            Inc(l_request_index);

            l_start_index:= l_request_index;
            while (l_request_index<= l_request_length)
                and (p_request[l_request_index]<> '"') do
              Inc(l_request_index);

            l_identifier_length:= l_request_index- l_start_index;
            SetLength(l_identifier, l_identifier_length);
            Move(p_request[l_start_index], l_identifier[1], l_identifier_length);

            l_lowercase_identifier:= LowerCase(l_identifier);
            l_index:= m_c_request_identifiers.Add(l_lowercase_identifier);
            m_oa_tokens[l_token_count]:= l_index;

            m_oa_token_positions[l_token_count]:= l_start_index;
            m_oa_token_lengths[l_token_count]:= l_identifier_length;

            // -- skip "
            Inc(l_request_index);

            Inc(l_token_count);
          end; // analyze_litteral_string

        begin // fill_identifier_list_and_token_array
          l_request_index:= 1;
          l_token_count:= 0;

          while (l_request_index<= l_request_length) and (m_error_index= 0) do
          begin
            case p_request[l_request_index] of
              'a'..'z', 'A'..'Z',
                '0'..'9' : analyze_identifier;
              '"' : analyze_litteral_string;
              ' ' : Inc(l_request_index);
              '(' : begin
                      m_oa_tokens[l_token_count]:= k_token_opening_parenthesis;
                      m_oa_token_positions[l_token_count]:= l_request_index;
                      m_oa_token_lengths[l_token_count]:= 1;
                      Inc(l_request_index);
                      Inc(l_token_count);
                    end;
              ')' : begin
                      m_oa_tokens[l_token_count]:= k_token_closing_parenthesis;
                      m_oa_token_positions[l_token_count]:= l_request_index;
                      m_oa_token_lengths[l_token_count]:= 1;
                      Inc(l_request_index);
                      Inc(l_token_count);
                    end;
              '.' : begin
                      m_oa_tokens[l_token_count]:= k_token_end;
                      m_oa_token_positions[l_token_count]:= l_request_index;
                      m_oa_token_lengths[l_token_count]:= 1;
                      Inc(l_request_index);
                      Inc(l_token_count);
                    end;
              else
                m_error_index:= l_request_index;
                m_error_length:= 1;
                Break;
            end; // case
          end; // while
        end; // fill_identifier_list_and_token_array

      begin // tokenize_request
        p_request:= p_request+ '.';
        m_request:= p_request;

        l_request_length:= Length(p_request);

        // -- first count the identifiers and the tokens
        m_c_request_identifiers:= tStringList.Create;
        get_identifiers_and_count_tokens;

        // -- now fill the identifier list and the token array
        if m_error_index= 0
          then fill_identifier_list_and_token_array;
      end; // tokenize_request

    function c_request_evaluator.f_display_token_type(p_token_type: Integer): String;
      begin
        case p_token_type  of
          k_token_AND : Result:= 'AND';
          k_token_OR : Result:= 'OR';
          k_token_NOT : Result:= 'NOT';
          k_token_opening_parenthesis : Result:= '(';
          k_token_closing_parenthesis : Result:= ')';
          k_token_end : Result:= '.';
          else
            Result:= m_c_request_identifiers[p_token_type];
        end; // case
      end; // f_display_token_type

    procedure c_request_evaluator.redisplay_request;
      var l_index: Integer;
          l_request: String;
      begin
        l_request:= '';

        For l_index:= 0 to Length(m_oa_tokens)- 1 do
          l_request:= l_request+ f_display_token_type(m_oa_tokens[l_index])+ ' ';

        display(l_request);
      end; // redisplay_request

    function c_request_evaluator.f_evaluate_request(p_c_text_searcher: c_text_searcher): boolean;
      type t_symbol_type= Integer;
      var // -- the position in the tokenized request
          l_token_index: Integer;
          // -- the current symbol
          l_symbol_type: t_symbol_type;
          l_error_count: Integer;
          l_first_error_token_index: Integer;

      procedure trace_evaluation(p_text: String);
        begin
          if m_trace_evaluation
            then display(p_text);
        end; // trace_evaluation

      procedure read_next_symbol;
        begin
          l_symbol_type:= m_oa_tokens[l_token_index];
          trace_evaluation('next_tok, ix= '+ IntToStr(l_token_index)+ ' type= '+ IntToStr(l_symbol_type)
            + ' '+ f_display_token_type(l_symbol_type));

          Inc(l_token_index);
        end; // read_next_symbol

      procedure display_evaluation_error(p_error: String);
        begin
          trace_evaluation(m_request);
          trace_evaluation(f_spaces(m_oa_token_positions[l_token_index- 1]- 1)+ '^ ***');
          trace_evaluation(p_error);

          if l_first_error_token_index= -1
            then l_first_error_token_index:= l_token_index- 1;
          Inc(l_error_count);
        end; // display_evaluation_error

      function f_evaluate_expression: Boolean;

        function f_evaluate_term: Boolean;

          function f_evaluate_factor: Boolean;
            var l_identifier: String;
            begin
              trace_evaluation('> factor ix= '+ IntToStr(l_token_index)+ ' val= '+ f_display_token_type(l_symbol_type));

              case l_symbol_type of
                k_token_opening_parenthesis :
                  begin
                    trace_evaluation('parent');
                    // -- skip (
                    read_next_symbol;

                    Result:= f_evaluate_expression;

                    if l_symbol_type= k_token_closing_parenthesis
                      then read_next_symbol
                      else display_evaluation_error('in "(expr)" manque )');
                  end;

                k_token_NOT :
                  begin
                    trace_evaluation('NOT');
                    read_next_symbol;

                    Result:= NOT f_evaluate_factor;
                    // -- do NOT read next symbol: was read by compile_expression
                  end;

                else
                  if l_symbol_type>= 0
                    then begin
                        trace_evaluation('get id '+ IntToStr(l_symbol_type));

                        l_identifier:= m_c_request_identifiers[l_symbol_type];
                        trace_evaluation('  '+ l_identifier);

                        // -- look if the symbol is in the text
                        Result:= p_c_text_searcher.f_found_string(l_identifier);
                        read_next_symbol;
                      end
                    else begin
                        // -- avoid warnings
                        Result:= False;
                        display_evaluation_error('attend fact: k, var, (: '+ IntToStr(l_symbol_type));
                      end;
              end; // case

              trace_evaluation('< factor ');
            end; // f_evaluate_factor

          begin // f_evaluate_term
            trace_evaluation('> term '+ IntToStr(l_token_index));

            Result:= f_evaluate_factor;

            while l_symbol_type= k_token_AND do
            begin
              read_next_symbol;
              Result:= Result AND f_evaluate_factor;
            end; // while l_symbol_type

            trace_evaluation('< term ');
          end; // f_evaluate_term

        begin // f_evaluate_expression
          trace_evaluation('> expression '+ IntToStr(l_token_index));

          Result:= f_evaluate_term;

          while l_symbol_type= k_token_OR do
          begin
            read_next_symbol;

            Result:= Result OR f_evaluate_term;
          end; // while

          trace_evaluation('< expression ');
        end; // f_evaluate_expression

      begin // f_evaluate_request
        l_error_count:= 0;
        l_first_error_token_index:= -1;

        l_token_index:= 0;
        read_next_symbol;

        Result:= f_evaluate_expression;
      end; // f_evaluate_request

    Destructor c_request_evaluator.Destroy;
      begin
        m_c_request_identifiers.Free;

        Inherited;
      end; // Destroy

    begin // u_c_request_evaluator
    end. // u_c_request_evaluator


