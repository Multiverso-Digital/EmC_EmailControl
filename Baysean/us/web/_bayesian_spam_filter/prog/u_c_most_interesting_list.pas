// 002 u_c_most_interesting_list
// 25 mar 2008

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_c_most_interesting_list;
  interface
    uses u_c_basic_object;

    type t_most_interesting_data= Record
                               m_how_far_away_from_05: Double;
                               m_probability: Double;
                               m_token: String;
                             end; // t_probability_data

         c_most_interesting_list= class(c_basic_object)
                                    m_count_max: Integer;
                                    m_count: Integer;

                                    m_most_interesting_array: Array of t_most_interesting_data;

                                    Constructor create_most_interesting_list(p_name: String;
                                        p_count_max: Integer);
                                    procedure add_most_interesting_decreasing(p_how_far_away_from_05, p_probability: Double;
                                        p_token: String);
                                    procedure display_most_interesting_list(p_integer, p_decimal: Integer);
                                    Destructor Destroy; Override;
                                  end; // c_most_interesting_list

  implementation
    uses SysUtils, u_c_display;

    // -- c_best_probability_list

    Constructor c_most_interesting_list.create_most_interesting_list(p_name: String;
        p_count_max: Integer);
      var l_index: Integer;
      begin
        Inherited create_basic_object(p_name);
        m_count_max:= p_count_max;

        SetLength(m_most_interesting_array, m_count_max);

        // -- debug
        for l_index:= 0 to m_count_max- 1 do
        begin
          m_most_interesting_array[l_index].m_probability:= 0;
          m_most_interesting_array[l_index].m_token:= '?';
        end;
      end; // create_best_probability_list

    procedure c_most_interesting_list.add_most_interesting_decreasing(
        p_how_far_away_from_05, p_probability: Double; p_token: String);
        // -- increasing order
      const k_debug: Boolean= False;
      var l_insert_index: Integer;
          l_move_index: Integer;
      begin
        if m_count= 0
          then begin
              // -- empty: insert at the first position
              l_insert_index:= 0;
              // -- prepare next
              Inc(m_count);
              if k_debug
                then display('insert_first');
            end
          else
            // -- only insert if
            // --  - either not full
            // --  - or the probability is greater then our smallest probability
            if (p_how_far_away_from_05> m_most_interesting_array[m_count- 1].m_how_far_away_from_05)
               or (m_count< m_count_max)
              then begin
                  // -- find the last item lower than our probability
                  l_insert_index:= 0;
                  if k_debug
                    then display(Format('  search %7.0f  %7.0f ',
                      [m_most_interesting_array[0].m_probability, m_most_interesting_array[m_count- 1].m_probability]));

                  while (l_insert_index< m_count)
                      and (m_most_interesting_array[l_insert_index].m_how_far_away_from_05>= p_how_far_away_from_05) do
                    Inc(l_insert_index);
                  if m_count< m_count_max
                    then Inc(m_count);
                  if k_debug
                    then display('insert_at '+ IntToStr(l_insert_index));
                end
              else begin
                  // -- too small: no insertion
                  l_insert_index:= -1;
                  if k_debug
                    then display('too_small');
                end;

        if l_insert_index>= 0
          then begin
              if l_insert_index< m_count- 1
                then begin
                    if k_debug
                      then display(Format('move %4d .. %4d  ->  %4d .. %4d ',
                          [l_insert_index, m_count- 2, l_insert_index+ 1, m_count- 1]));

                    for l_move_index:= m_count- 1 downto l_insert_index+ 1 do
                    begin
                      if k_debug
                        then display(Format('  move %4d ', [l_move_index]));
                      m_most_interesting_array[l_move_index]:= m_most_interesting_array[l_move_index- 1];
                    end;

                    if k_debug
                      then begin
                          m_most_interesting_array[l_insert_index].m_token:= '+';
                          display_most_interesting_list(5, 0);
                          stop('');
                        end;
                  end;

              // -- now insert
              if k_debug
                then display(Format('  ix %3d,  count %3d', [l_insert_index, m_count]));
              m_most_interesting_array[l_insert_index].m_how_far_away_from_05:= p_how_far_away_from_05;
              m_most_interesting_array[l_insert_index].m_probability:= p_probability;
              m_most_interesting_array[l_insert_index].m_token:= p_token;
          end;
      end; // add_most_interesting_decreasing

    procedure c_most_interesting_list.display_most_interesting_list(p_integer, p_decimal: Integer);
      var l_format: String;
          l_probability_index: Integer;
      begin
        l_format:= IntToStr(p_integer)+ '.'+ IntToStr(p_decimal);
        for l_probability_index:= 0 to m_count- 1 do
          with m_most_interesting_array[l_probability_index] do
            display(Format('%7d %'+ l_format+ 'f  ', [l_probability_index, m_probability])+ m_token);
      end; // display_most_interesting_list

    Destructor c_most_interesting_list.Destroy;
      begin
        Inherited;
      end; // Destroy

    begin // u_c_best_probability_list
    end. // u_c_best_probability_list


