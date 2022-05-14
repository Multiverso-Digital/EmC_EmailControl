// 002 u_c_bayes_spam_filter_2
// 25 mar 2008

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_c_bayes_spam_filter_2;
  interface
    uses Classes, u_c_basic_object
        , u_c_string_hash_table
        , u_c_mail_scanner_4
        ;

    const k_spam_false= False;
          k_spam_truee= True;

    type c_bayes_spam_filter=
             class(c_basic_object)
               m_e_mail_scanning: Boolean;

               m_c_ok_hash_token_frequency_list,
                   m_c_spam_hash_token_frequency_list: c_hash_table;

               // -- A list of probabilities that the given word might appear in a Spam text
               m_c_spam_token_probability_list: c_hash_table;

               // -- parameters
               // -- do not analize token smaller than
               m_token_length_min: Integer;
               // -- do not scan more than this limit
               m_buffer_size_max: Integer;

               // --   good words are multiplied by 2
               m_ok_token_weight: Integer;

               // -- only compute probability if at least 5 occurences
               m_min_token_count: Integer;

               // -- if in spam only or in ok_only
               m_score_min: Double;

               // -- spam only, < 10 occurences
               m_likely_spam_score: Double;
               // -- spam only, > 10 occurences
               m_certain_spam_score: Double;
               m_certain_spam_count: Integer;

               // -- spam and good e-mail counts (NOT the tokens)
               m_spam_e_mail_count, m_ok_e_mail_count: Integer;

               // -- the number of words to keep for the ratio
               m_interesting_word_count: Integer;
               // -- if token in new e-mail, but not in training set
               m_e_mail_unknown_token_probability: Double;

               // -- stats
               m_total_e_mail_length, m_max_e_mail_length: Integer;
               m_e_mail_token_count_stat: Integer;

               m_debug_frequency_parsing: Boolean;

               m_empty_token_count: Integer;

               Constructor create_bayes_spam_filter(p_name: String);

                 procedure _add_raw_tokens(p_c_mail_scanner: c_mail_scanner;
                     p_c_test_hash_token_frequency_list: c_hash_table;
                     p_is_spam: Boolean);
                 procedure _add_e_mail_file_tokens(p_c_mail_scanner: c_mail_scanner;
                     p_c_test_hash_token_frequency_list: c_hash_table;
                     p_is_spam: Boolean);
               procedure add_file_tokens(p_full_file_name: string;
                   p_is_spam: Boolean);
               procedure compute_spam_probabilities;

               function f_test_mail(p_full_file_name: String;
                   p_c_result_list: tStrings; var pv_token_count: Integer): Double;

               Destructor Destroy; Override;
             end; // c_bayes_spam_filter

  implementation
    uses SysUtils, Math
        , u_types_constants, u_characters
        , u_c_display
        , u_c_most_interesting_list
        ;

    // -- c_bayes_spam_filter

    Constructor c_bayes_spam_filter.create_bayes_spam_filter(p_name: String);
      begin
        Inherited create_basic_object(p_name);

        m_c_ok_hash_token_frequency_list:= c_hash_table.create_hash_table('ok');
        m_c_spam_hash_token_frequency_list:= c_hash_table.create_hash_table('spam');

        // -- addjustment parameters
        m_token_length_min:=5;
        m_buffer_size_max:= 4* 1024;

        m_ok_token_weight:= 2;
        m_min_token_count:= 5;

        m_score_min:= 0.011;

        // -- if only spam (not in ok), never assign 1.0, but close to it
        m_likely_spam_score:= 0.9998;
        m_certain_spam_score:= 0.9999;

        m_certain_spam_count:= 10;

        // -- how many are kept to compute the ratio
        m_interesting_word_count:= 15;  // 15 (later changed to 20)
        m_e_mail_unknown_token_probability:= 0.4;
      end; // create_bayes_spam_filter

    procedure c_bayes_spam_filter._add_raw_tokens(p_c_mail_scanner: c_mail_scanner;
        p_c_test_hash_token_frequency_list: c_hash_table;
        p_is_spam: Boolean);
        // -- scan full text (up to 4K max). No e-mail analysis
      var l_token: String;
      begin
        with p_c_mail_scanner do
        begin
          m_buffer_size:= Min(m_buffer_size, m_buffer_size_max);

          while m_buffer_index< m_buffer_size do
          begin
            l_token:= LowerCase(f_token);
            if l_token= ''
              then begin
                  // -- because length< 5
                  Inc(m_empty_token_count);
                end
              else
                if p_c_test_hash_token_frequency_list<> Nil
                  then p_c_test_hash_token_frequency_list.f_pt_add_hash_data(l_token, 1)
                  else
                    if p_is_spam
                      then m_c_spam_hash_token_frequency_list.f_pt_add_hash_data(l_token, 1)
                      else m_c_ok_hash_token_frequency_list.f_pt_add_hash_data(l_token, 1);
          end; // whild p_c_mail_scanner, m_buffer_index
        end;
      end; // _add_raw_tokens

    procedure c_bayes_spam_filter._add_e_mail_file_tokens(p_c_mail_scanner: c_mail_scanner;
        p_c_test_hash_token_frequency_list: c_hash_table;
        p_is_spam: Boolean);
        // -- scan and anlyze e-mail text (up to 4K max)
        // -- param NIL for spam or ok, not NIL for test mail
      type t_mime_content_type= (e_unknown_content, e_text_content, e_html_content
               , e_skip_content
               , e_application_content, e_image_content
               );
      var l_token: String;
          l_content_type_string: String;
          l_mime_content_type: t_mime_content_type;
          l_c_hash_token_frequency_list_ref: c_hash_table;
      begin
        with p_c_mail_scanner do
        begin
          m_buffer_size:= Min(m_buffer_size, m_buffer_size_max* 3);

          // -- skip header: look for 2 new-lines
          while (m_buffer_index+ 3< m_buffer_size)
              and not
                (
                    (m_oa_text_buffer[m_buffer_index]= k_return)
                  and
                    (m_oa_text_buffer[m_buffer_index+ 1]= k_line_feed)
                  and
                    (m_oa_text_buffer[m_buffer_index+ 2]= k_return)
                  and
                    (m_oa_text_buffer[m_buffer_index+ 3]= k_line_feed)
                 )
              do
            inc(m_buffer_index);

          if m_buffer_index+ 3>= m_buffer_size
            then Exit;

          Inc(m_buffer_index, 4);

          if m_debug_frequency_parsing
            then display('  '+ IntTostr(m_buffer_index));
          if p_c_test_hash_token_frequency_list<> Nil
            then l_c_hash_token_frequency_list_ref:= p_c_test_hash_token_frequency_list
            else
              if p_is_spam
                then l_c_hash_token_frequency_list_ref:= m_c_spam_hash_token_frequency_list
                else l_c_hash_token_frequency_list_ref:= m_c_ok_hash_token_frequency_list;

          l_mime_content_type:= e_unknown_content;

          while m_buffer_index< m_buffer_size do
          begin
            // -- NOT LowerCase, to distinguish "Content-Type" from .HTML "meta content-type"
            l_token:= f_mail_token;

            if l_token= ''
              then begin
                  // -- because length< 5
                  Inc(m_empty_token_count);
                end
              else begin
                  if m_debug_frequency_parsing
                    then display('   '+ IntToStr(m_buffer_index)+ ' §§§'+ l_token+ '§§§');

                  if (l_token= 'Content-Type')
                      and f_end_of_line(m_buffer_index- Length('Content-Type'))
                    then begin
                        m_token_min:= 3;

                        l_content_type_string:= f_mail_token;
                        if l_content_type_string= 'text'
                          then l_content_type_string:= l_content_type_string+ '/'+ f_mail_token;

                        // -- TODO if text/xxx should also check encoding: uuencode

                        if l_content_type_string= 'application'
                          then l_mime_content_type:= e_application_content else
                        if l_content_type_string= 'image'
                          then l_mime_content_type:= e_image_content else
                        if l_content_type_string= 'text/plain'
                          then l_mime_content_type:= e_text_content else
                        if l_content_type_string= 'text/html'
                          then l_mime_content_type:= e_html_content else
                        if l_content_type_string= 'multipart'
                          then l_mime_content_type:= e_skip_content else
                        // -- in .HTML meta
                        if l_content_type_string= 'content'
                          then l_mime_content_type:= e_html_content // l_mime_content_type:= e_skip_content
                        ;

                        if m_debug_frequency_parsing
                          then display('Content-Type '+ IntTostr(m_buffer_index)+ l_content_type_string);

                        m_token_min:= 5;

(*
                        // -- skip until empty line
                        // --   but should check that was after Return
                        while (m_buffer_index+ 3< m_buffer_size)
                            and not
                              (
                                  (m_oa_text_buffer[m_buffer_index]= k_return)
                                and
                                  (m_oa_text_buffer[m_buffer_index+ 1]= k_line_feed)
                                and
                                  (m_oa_text_buffer[m_buffer_index+ 2]= k_return)
                                and
                                  (m_oa_text_buffer[m_buffer_index+ 3]= k_line_feed)
                              )
                            do
                          Inc(m_buffer_index);
*)
                      end; // if l_token= 'Content-Type'

                  if m_debug_frequency_parsing
                    then display('  do_add');

                  case l_mime_content_type of
                    e_text_content, e_unknown_content:
                        begin
                          if m_debug_frequency_parsing
                            then display('  add_txt  '+ l_token);

                          // -- debug
                          l_c_hash_token_frequency_list_ref.f_pt_add_hash_data(LowerCase(l_token), 1);
                          Inc(l_c_hash_token_frequency_list_ref.m_token_length, Length(l_token));

                        end;
                    e_html_content :
                        begin
                          if m_debug_frequency_parsing
                            then display('  add_html '+ l_token);

                          // -- debug
                          l_c_hash_token_frequency_list_ref.f_pt_add_hash_data(LowerCase(l_token), 1);
                          Inc(l_c_hash_token_frequency_list_ref.m_html_token_length, Length(l_token));
                        end;
                    e_skip_content, e_application_content :
                        begin
                          if m_debug_frequency_parsing
                            then display('  skip_content '+ l_token);
                        end;
                    Else
                      if m_debug_frequency_parsing
                        then display(Format('  Break %3d   ix %7d ', [Ord(l_mime_content_type), m_buffer_index]));
                      Break;
                  end; // case l_content_type
                end;
          end; // whild m_buffer_index

          if m_debug_frequency_parsing
            then display(Format('  end %3d   ix %7d  buf_size %6d', [Ord(l_mime_content_type), m_buffer_index, m_buffer_size]));

          // -- do not count the one over 10k (small average bias)
          if m_buffer_index< 1024* 10
            then Inc(m_total_e_mail_length, m_buffer_index);
          m_max_e_mail_length:= Max(m_max_e_mail_length, m_buffer_index);
        end; // with p_c_mail_scanner
      end; // _add_e_mail_file_tokens

    procedure c_bayes_spam_filter.add_file_tokens(p_full_file_name: string;
        p_is_spam: Boolean);
      begin
        with c_mail_scanner.create_mail_scanner('', m_token_length_min) do
        begin
          f_load_from_file(p_full_file_name);

          if m_e_mail_scanning
            then _add_e_mail_file_tokens(f_c_self, Nil, p_is_spam)
            else _add_raw_tokens(f_c_self, Nil, p_is_spam);

          Free;
        end; // with c_mail_scanner
      end; // add_file_tokens

    procedure c_bayes_spam_filter.compute_spam_probabilities;
      // -- Do the math to populate the probabilities collection

      procedure compute_token_probability(p_token: String;
          p_ok_frequency, p_spam_frequency: Integer);
        const k_debug= False;
        var l_ok_frequency, l_spam_frequency: Integer;
            l_ok_factor, l_spam_factor, l_probability: Double;
        begin
           l_ok_frequency:= p_ok_frequency* m_ok_token_weight;
           l_spam_frequency:= p_spam_frequency;

           // -- only compute if has found significant occurences in the
           // --   spam+ ok corpus
           if l_ok_frequency + l_spam_frequency >= m_min_token_count
            then begin
                if l_spam_frequency= 0
                  then l_probability:= m_score_min
                  else
                    if l_ok_frequency= 0
                      then begin
                          // -- special case for Spam-only tokens.
                          // --   - 0.9998 for tokens only found in spam,
                          // --   - 0.9999 if found more than 10 times
                          if l_spam_frequency > m_certain_spam_count
                            then l_probability:= m_certain_spam_score
                            else l_probability:= m_likely_spam_score;
                        end
                      else begin
                          // -- in both spam and ok sets
                          l_ok_factor:= l_ok_frequency / m_ok_e_mail_count;
                          l_spam_factor:= l_spam_frequency / m_spam_e_mail_count;

                          l_probability:= l_spam_factor / (l_ok_factor + l_spam_factor);
                        end;

                // -- now add the probability entry
                // -- include the total occurence, only for analysis
                m_c_spam_token_probability_list.f_pt_add_hash_probability_data(p_token,
                    l_ok_frequency + l_spam_frequency, l_probability);

                if k_debug
                  then display(Format('%7d %7d    %7d  %7d   %0.7f  ',
                      [p_ok_frequency, p_spam_frequency,
                       l_ok_frequency, l_spam_frequency, l_probability])+ p_token);
              end; // occured more than 5 time
        end; // compute_token_probability

      var l_ok_token, l_spam_token: String;
          l_pt_spam_hash_data: t_pt_hash_data;

          l_ok_frequency, l_spam_frequency: Integer;

      begin // compute_spam_probabilities
        m_c_spam_token_probability_list.Free;

        m_c_spam_token_probability_list:= c_hash_table.create_hash_table('');

        display_line;
        display('> __ok');

        with c_hash_iterator.create_hash_iterator('', m_c_ok_hash_token_frequency_list) do
        begin
          while f_move_next do
            with f_pt_current_hash_data^ do
            begin
              l_ok_frequency:= m_hash_frequency;
              l_ok_token:= m_hash_string;

              // -- find out if this token also has a spam value
              l_pt_spam_hash_data:= m_c_spam_hash_token_frequency_list.f_pt_search_hash_data(l_ok_token);
              if l_pt_spam_hash_data<> nil
                then l_spam_frequency:= l_pt_spam_hash_data.m_hash_frequency
                else l_spam_frequency:= 0;

              compute_token_probability(l_ok_token, l_ok_frequency, l_spam_frequency);
            end; // while f_move_next

          Free;
        end; // with c_hash_iterator.create_hash_iterator
        display('< __ok');

        display_line;
        display('> __spam');
        with c_hash_iterator.create_hash_iterator('', m_c_spam_hash_token_frequency_list) do
        begin
          while f_move_next do
            with f_pt_current_hash_data^ do
            begin
              // -- eliminate what was added while browsing the "ok" list
              l_spam_token:= m_hash_string;

              if m_c_ok_hash_token_frequency_list.f_pt_search_hash_data(l_spam_token)= Nil
                then begin
                    l_spam_frequency:= m_hash_frequency;
                    compute_token_probability(l_spam_token, 0, l_spam_frequency);
                  end;
            end; // while f_move_next

          Free;
        end; // with c_hash_iterator.create_hash_iterator
        display('< __spam');
      end; // compute_spam_probabilities

    function c_bayes_spam_filter.f_test_mail(p_full_file_name: String;
        p_c_result_list: tStrings; var pv_token_count: Integer): Double;
        // -- Returns the probability that the supplied body of text is spam
      var l_c_test_mail_token_frequency_list: c_hash_table;

      procedure build_mail_token_list;
        begin
          with c_mail_scanner.create_mail_scanner('', m_token_length_min) do
          begin
            f_load_from_file(p_full_file_name);

            if m_e_mail_scanning
              then _add_e_mail_file_tokens(f_c_self, l_c_test_mail_token_frequency_list, True)
              else _add_raw_tokens(f_c_self, l_c_test_mail_token_frequency_list, True);

            m_e_mail_token_count_stat:= l_c_test_mail_token_frequency_list.f_hash_data_count;
            pv_token_count:= m_e_mail_token_count_stat;

            Free;
          end; // with c_mail_scanner
        end; // build_mail_token_list

      var l_c_email_most_interesting_list: c_most_interesting_list;

      procedure compute_mail_token_probabilities;
        var l_mail_token: String;
            l_pt_mail_hash_data: t_pt_hash_data;

            l_spam_probability: Double;
            l_how_far_away_from_05: Double;
        begin
          l_c_email_most_interesting_list:= c_most_interesting_list.create_most_interesting_list('', m_interesting_word_count);

          with c_hash_iterator.create_hash_iterator('', l_c_test_mail_token_frequency_list) do
          begin
            while f_move_next do
              with f_pt_current_hash_data^ do
              begin
                l_mail_token:= m_hash_string;

                l_pt_mail_hash_data:= m_c_spam_token_probability_list.f_pt_search_hash_data(l_mail_token);
                if l_pt_mail_hash_data<> Nil
                  then l_spam_probability:= l_pt_mail_hash_data^.m_hash_probability
                  else l_spam_probability:= m_e_mail_unknown_token_probability;

                // -- add to the email probability list
                // -- rank by "how far from 0.5"
                l_how_far_away_from_05:= Abs(0.5- l_spam_probability);

                l_c_email_most_interesting_list.add_most_interesting_decreasing(
                    l_how_far_away_from_05, l_spam_probability, l_mail_token);
              end; // while f_move_next

            Free;
          end; // with c_hash_iterator.create_hash_iterator
        end; // compute_mail_token_probabilities

      procedure compute_composite_with_most_spams;
          // -- Combine the 15 most interesting probabilities together into one.
        var // -- abc..n
            l_mutliplied: Double;
            // --  (1 - a)(1 - b)(1 - c)..(1-n)
            l_complement_mutilplied: Double;

            l_best_index: Integer;
            l_probability: Double;
            l_ratio: Double;
        begin
          l_mutliplied:= 1;
          l_complement_mutilplied:= 1;
          p_c_result_list.Clear;

          with l_c_email_most_interesting_list do
            for l_best_index:= 0 to m_count- 1 do
              with m_most_interesting_array[l_best_index] do
              begin
                l_probability:= m_probability;
                l_mutliplied:= l_mutliplied * l_probability;
                l_complement_mutilplied:= l_complement_mutilplied * (1 - l_probability);

                l_ratio:= l_mutliplied / (l_mutliplied + l_complement_mutilplied);
                p_c_result_list.Add(Format('proba %0.7f  away %0.7f => ratio %1.7f ',
                    [l_probability, m_how_far_away_from_05, l_ratio])+ m_token);
              end; // with l_c_email_most_interesting_list

          Result:= l_mutliplied / (l_mutliplied + l_complement_mutilplied);
        end; // compute_composite_with_most_spams

      begin // f_test_mail
        l_c_test_mail_token_frequency_list:= c_hash_table.create_hash_table('');

        build_mail_token_list;
        compute_mail_token_probabilities;
        compute_composite_with_most_spams;

        l_c_test_mail_token_frequency_list.Free;
      end; // f_text_mail

    Destructor c_bayes_spam_filter.Destroy;
      begin
        m_c_ok_hash_token_frequency_list.Free;
        m_c_spam_hash_token_frequency_list.Free;

        Inherited;
      end; // Destroy

    begin // u_c_bayes_spam_filter
    end. // u_c_bayes_spam_filter


