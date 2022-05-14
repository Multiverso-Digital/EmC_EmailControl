// 007 u_types_constants
// 15 dec 2004

// -- (C) Felix John COLIBRI 2004
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_types_constants;
  interface

    const k_tabulation= chr(9);
          k_line_feed= char(10);
          k_return= chr(13);
          k_back_space= chr(8);
          k_escape= chr(27);

          k_return_line_feed= k_return+ k_line_feed;
          k_new_line= k_return+ k_line_feed;
          k_digits= ['0'..'9'];
          k_blanks= [k_tabulation, ' '];
          k_letters= ['a'..'z', 'A'..'Z'];

          k_word_max= 65534;
         
    type t_characters= array[0..0] of Char;
         t_pt_characters= ^t_characters;

         t_pt_character= ^Char;

         t_pt_byte= ^Byte;
         t_pt_integer= ^Integer;

         t_bytes= array[0..0] of Byte;
         t_pt_bytes= ^t_bytes;

         t_oa_bytes= array of Byte;
         t_oa_characters= array of Char;

         t_handle_procedure= procedure(p_pt: Pointer);

         t_set_of_characters= Set of Char;

         t_byte_date= packed record
                               m_day, m_month, m_year: byte;
                             end;
         t_date_4= packed record
                            m_day, m_month: byte;
                            m_year: Integer;
                          end;


  implementation

    begin
    end.













