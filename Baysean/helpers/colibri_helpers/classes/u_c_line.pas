// 017 u_c_line
// 13 jun 2005

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_c_line;
  interface
    uses u_c_basic_object, u_types_constants;

    type c_line= class(c_basic_object)
                   m_the_line: String;
                   m_line_index, m_line_size: Word;
                   m_line_line_number: Word;
                   m_buffer_index_of_start: Integer;

                   m_extract_error: Integer;

                   Constructor create_line(p_name: String); Virtual;
                   function f_extract_string_start_length(p_start, p_length: Integer): String;
                   function f_extract_string_start_end(p_start, p_end: Integer): String;
                   procedure set_line(p_line: String);
                   destructor Destroy; Override;
                 end;

  implementation
    uses SysUtils, u_strings, u_c_display;

    constructor c_line.create_line(p_name: String);
      begin
        Inherited create_basic_object(p_name);
      end; // Create

    function c_line.f_extract_string_start_length(p_start, p_length: Integer): String;
      begin
        m_extract_error:= 0;
        if p_length= 0
          then Result:= ''
          else begin
              if (p_length< 0) or (p_start< 1) or (p_start+ p_length- 1> m_line_size)
                then begin
                    m_extract_error:= 1;
                    display(m_the_line);
                    display(f_spaces(p_start- 1)+ '^');
                    display(f_spaces(p_start+ p_length- 1)+ '|');
                    display(f_spaces(m_line_size- 1)+ '^');
                    display('*** m_c_line.f_extract_string_start_length '
                        // + m_c_file_name.m_complete_name+ ' '
                        + IntToStr(p_start)+ ' '+ IntToStr(p_length)+ ' '+ IntToStr(m_line_size)
                        + ' '+ IntToStr(p_start+ p_length));
                    Result:= m_the_line+ chr(13)+ chr(10)
                        + '*** m_c_line.f_extract_string_start_length '
                        // + m_c_file_name.m_complete_name+ ' '
                        + IntToStr(p_start)+ ' '+ IntToStr(p_length)+ ' '+ IntToStr(m_line_size)
                        + ' '+ IntToStr(p_start+ p_length);
                  end
                else begin
                    SetLength(Result, p_length);
                    Move(m_the_line[p_start], Result[1], p_length);
                  end;
            end;
      end; // f_extract_string_start_length

    function c_line.f_extract_string_start_end(p_start, p_end: Integer): String;
      begin
        Result:= f_extract_string_start_length(p_start, p_end+ 1- p_start)
      end; // f_extract_string_start_end

    procedure c_line.set_line(p_line: String);
      begin
        m_the_line:= p_line;
        m_line_size:= Length(m_the_line);
        m_line_index:= 1;
      end; // set_line

    destructor c_line.Destroy;
      begin
      end; // Destroy

    begin // u_c_line
    end. // u_c_line
 u_c_line
 u_c_line
