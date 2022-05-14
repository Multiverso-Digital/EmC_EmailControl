// 002 u_c_mail_filter_result_list
// 25 mar 2008

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_c_mail_filter_result_list;
  interface
    uses Classes, u_c_basic_object;

    type c_mail_filter_result= // one "mail_filter_result"
             Class(c_basic_object)
               // -- m_name: the percentage as a string
               m_file_name: String;
               m_c_probability_list: tStringList;

               Constructor create_mail_filter_result(p_name, p_file_name: String;
                   p_c_probability_list: tStringList);
               function f_display_mail_filter_result: String;
               function f_c_self: c_mail_filter_result;
               Destructor Destroy; Override;
             end; // c_mail_filter_result

  implementation
    uses SysUtils, u_c_display;

    // -- c_mail_filter_result

    Constructor c_mail_filter_result.create_mail_filter_result(p_name, p_file_name: String;
        p_c_probability_list: tStringList);
      begin
        Inherited create_basic_object(p_name);

        m_file_name:= p_file_name;

        m_c_probability_list:= tStringList.Create;
        m_c_probability_list.Assign(p_c_probability_list);
      end; // create_mail_filter_result

    function c_mail_filter_result.f_display_mail_filter_result: String;
      begin
        Result:= Format('%-10s ', [m_name]);
      end; // f_display_mail_filter_result

    function c_mail_filter_result.f_c_self: c_mail_filter_result;
      begin
        Result:= Self;
      end; // f_c_self

    Destructor c_mail_filter_result.Destroy;
      begin
        FreeAndNil(m_c_probability_list);

        InHerited;
      end; // Destroy


    begin // u_c_mail_filter_result_list
    end. // u_c_mail_filter_result_list
