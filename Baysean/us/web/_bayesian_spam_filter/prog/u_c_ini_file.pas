// 003 u_c_ini_file
// 29 oct 2006

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

// -- remember the last pathes used (or other application parameters)
// -- saved in exe/ini (to avoid cluttering the exe)
// -- has
// --  - default   'fig_ini.txt'
// --  - versions  'fig_ini_assy.txt', 'fig_ini_gencot.txt' ...


// -- CAUTION can be tricky if uses in conjunction with directorylistbox change
// --   and 2 dir structures (cf delphi_prog / replace. Solved in site_editor repl)

(*$r+*)

unit u_c_ini_file;
  interface
    uses Classes, u_c_basic_object;

    type c_ini_file= class(c_basic_object)
                       // -- m_name: the application name "FIG"
                       m_ini_path: String;
                       // -- the pure file name "fig_ini" or "fig_ini_gencot"
                       m_ini_pure_file_name: String;
                       m_loaded: Boolean;
                       m_modified: Boolean;

                       m_c_parameter_list: tStringList;

                       Constructor create_ini_file(p_name: String);

                       procedure set_parameter(p_key, p_value: String);
                       function f_initialize_parameter(p_key, p_default: String): String;
                       function f_get_parameter(p_key: String): String;
                       function f_get_parameter_by_index(p_parameter_index: Integer): String;

                       procedure display_ini_file;

                       procedure save_to_default_file;
                       procedure load_from_default_file;
                       function f_check_directories: String;

                       Destructor Destroy; Override;
                     end; // c_ini_file

  implementation
    uses SysUtils, u_c_display
        , u_dir, u_file
        ;

    // -- c_ini_file

    Constructor c_ini_file.create_ini_file(p_name: String);
      begin
        Inherited create_basic_object(p_name);

        m_ini_path:= f_exe_path+ 'ini\';
        f_create_path(m_ini_path);
        // m_ini_pure_file_name:= m_name+ '_ini';
        if m_name= ''
          then m_ini_pure_file_name:= ChangeFileExt(f_exe_file_name, '')+ '_ini'
          else m_ini_pure_file_name:= m_name+ '_ini';

        m_c_parameter_list:= tStringList.Create;
      end; // create_ini_file

    procedure c_ini_file.set_parameter(p_key, p_value: String);
      begin
        m_c_parameter_list.Values[p_key]:= p_value;
        m_modified:= True;
      end; // set_parameter

    function c_ini_file.f_initialize_parameter(p_key, p_default: String): String;
      begin
        if not m_loaded
          then load_from_default_file;
        Result:= f_get_parameter(p_key);
        if Result= ''
          then begin
              Result:= p_default;
              set_parameter(p_key, p_default);
            end;
      end; // f_initialize_parameter

    function c_ini_file.f_get_parameter(p_key: String): String;
      begin
        Result:= m_c_parameter_list.Values[p_key];
      end; // f_get_parameter

    function c_ini_file.f_get_parameter_by_index(p_parameter_index: Integer): String;
      var l_parameter: String;
          l_equal_index: Integer;
      begin
        l_parameter:= m_c_parameter_list[p_parameter_index];
        l_equal_index:= Pos('=', l_parameter);
        if l_equal_index<= 0
          then Result:= ''
          else begin
              Result:= Trim(Copy(l_parameter, l_equal_index+ 1, Length(l_parameter)- l_equal_index));
            end;
      end; // f_get_parameter_by_index

    procedure c_ini_file.save_to_default_file;
      begin
        // stop('save');
        if m_modified
          then m_c_parameter_list.SaveToFile(m_ini_path+ m_ini_pure_file_name+ '.txt');
      end; // save_to_default_file

    procedure c_ini_file.display_ini_file;
      begin
        display_strings(m_c_parameter_list);
      end; // display_ini_file

    // -- file

    procedure c_ini_file.load_from_default_file;
      begin
        if FileExists(m_ini_path+ m_ini_pure_file_name+ '.txt')
          then m_c_parameter_list.LoadFromFile(m_ini_path+ m_ini_pure_file_name+ '.txt');
        m_loaded:= True;
      end; // load_from_default_file

    function c_ini_file.f_check_directories: String;
        // -- '' if all ok, else the string of the problem
      var l_path_index: Integer;
          l_path: String;
      begin
        Result:= '';

        with m_c_parameter_list do
          for l_path_index:= 0 to Count- 1 do
          begin
            l_path:= f_get_parameter_by_index(l_path_index);

            if Pos('.', l_path)<= 0
              then
                if not f_check_path(l_path)
                  then begin
                      Result:= l_path;
                      if Result= ''
                        then Result:= 'EMPTY';
                      Break;
                    end;
          end;
      end; // f_check_directories

    Destructor c_ini_file.Destroy;
      begin
        if m_modified
          then save_to_default_file;
        m_c_parameter_list.Free;

        Inherited;
      end; // Destroy

    begin // u_c_ini_file
    end. // u_c_ini_file
_ini_file
_ini_file
