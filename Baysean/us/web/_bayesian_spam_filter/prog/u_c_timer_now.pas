// 013 u_c_timer_now
// 20 dec 2004

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

// -- timer uses Now

(*$r+*)

unit u_c_timer_now;
  interface
    uses Classes, u_c_basic_object;

    type c_timer_now= class(c_basic_object)
                        public
                          m_start_time: tDateTime;

                          Constructor create_timer_now(p_name: String);
                          procedure start_timer;
                          function f_get_delta: tDateTime;
                          function f_display_delta: String;
                          Destructor Destroy; Override;
                      end;

  implementation
    Uses SysUtils, u_c_display;

    // -- c_timer_now

    Constructor c_timer_now.create_timer_now(p_name: String);
      begin
        Inherited create_basic_object(p_name);
        m_start_time:= Now;
      end; // create_timer_now

    procedure c_timer_now.start_timer;
      begin
        m_start_time:= Now;
      end; // start_timer

    function c_timer_now.f_get_delta: tDateTime;
      begin
        Result:= Now- m_start_time;
      end; // f_get_delta

    function c_timer_now.f_display_delta: String;
      begin
        Result:= FormatDateTime('hh:nn:ss', f_get_delta);
      end; // f_display_delta

    Destructor c_timer_now.Destroy;
      begin
        Inherited;
      end; // Destroy

    begin // u_c_timer_now
    end. // u_c_timer_now
timer_now
timer_now
