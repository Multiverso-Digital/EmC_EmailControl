// 020 u_handle_files_in_dirs
// 20 dec 2004

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

// -- recursive browsing of a directory

(*
    procedure call_back(p_level: Integer; p_dir, p_file_name: String;
          p_pt_data: Pointer);
      begin
      end; // call_back

      var l_path, l_extension: String;
      begin
        l_path:= k_initial_directory;
        l_extension:= '.HTML';
        handle_all_files_recursive(1, l_path, l_extension,
          [e_dir_recursive, e_dir_handle_file], my_callback, Nil);
*)

(*$r+*)

unit u_handle_files_in_dirs;
  interface
    uses SysUtils;

    type t_pr_handle_file= procedure(p_level: Integer; p_dir, p_file_name: String;
            p_pt_data: Pointer);

         t_dir_handling_type= (e_dir_recursive,
             e_dir_display_dir, e_dir_display_file, e_dir_display_all_file, e_dir_display_debug,
             e_dir_indent,
             // -- before and after recurse into a sub-dir
             e_dir_handle_dir_before, e_dir_handle_dir_after,
             e_dir_handle_dir, e_dir_handle_file);
         t_dir_handling_types= set of t_dir_handling_type;

    procedure handle_all_files_recursive(p_level: Integer; p_strict_path, p_extension: String;
        p_dir_handling_types: t_dir_handling_types;
        p_pr_handle_file: t_pr_handle_file; p_pt_data: Pointer);

    var g_search_record: tSearchRec;
        g_path_level_max: Integer= 0;

  implementation
    uses u_strings, u_c_display;

    procedure handle_all_files_recursive(p_level: Integer; p_strict_path, p_extension: String;
        p_dir_handling_types: t_dir_handling_types;
        p_pr_handle_file: t_pr_handle_file; p_pt_data: Pointer);
      var l_entry: tSearchRec;
          l_result: Integer;
          l_extension: String;
          l_spaces: String;
      begin
        if p_level> 50
          then display_bug_halt('');

        if e_dir_indent in p_dir_handling_types
          then l_spaces:= f_spaces(2* p_level)
          else l_spaces:= '';

        // -- display(l_spaces+ 'dir '+ IntToStr(p_level)+ ' '+ p_strict_path+ ' '+ p_filter);
        if e_dir_display_debug in p_dir_handling_types
          then display(' > dir '+ p_strict_path+ '\*.*');

        // -- always filter with *.* (to find subdirectories ?)
        // --   and check extension

        // -- find the first entry and save it in l_entry
        l_result:= FindFirst(p_strict_path+ '\*.*', faAnyfile, l_entry);
        if l_result= 0
          then begin
              if e_dir_display_debug in p_dir_handling_types
                then display('FindFirst Name >'+ l_entry.Name+ '<');
              if p_level= 1
                then begin
                  end;

              // -- skip . et .. at the beginning of every path
              if l_entry.Name= '.'
                then begin
                    l_result:= FindNext(l_entry);
                    if e_dir_display_debug in p_dir_handling_types
                      then display('skip . >'+ l_entry.Name+ '<');
                  end;
              if (l_result= 0) and (l_entry.Name= '..')
                then begin
                    l_result:= FindNext(l_entry);
                    if e_dir_display_debug in p_dir_handling_types
                      then display('skip .. >'+ l_entry.Name+ '<');
                  end;

              while l_result= 0 do
              begin
                if e_dir_display_debug in p_dir_handling_types
                  then display('while '+ l_entry.Name+ '<');

                if (l_entry.Attr and faDirectory)<> 0
                  then begin // -- recurse in the sub directory
                      with l_entry do
                      begin
                        if (Name<> '.') and (Name<> '..')
                          then begin
                              if e_dir_display_debug in p_dir_handling_types
                                then display('dir -> '+ name);

                              if Assigned(p_pr_handle_file) and (e_dir_handle_dir in p_dir_handling_types)
                                then begin
                                    g_search_record:= l_entry;
                                    p_pr_handle_file(p_level, p_strict_path+ '\', Name, p_pt_data);
                                  end;

                              // -- recurse
                              if e_dir_recursive in p_dir_handling_types
                                then handle_all_files_recursive(p_level+ 1, p_strict_path+ '\'+ Name, p_extension,
                                    p_dir_handling_types, p_pr_handle_file, p_pt_data);

                              if Assigned(p_pr_handle_file) and (e_dir_handle_dir_after in p_dir_handling_types)
                                then begin
                                    g_search_record:= l_entry;
                                    p_pr_handle_file(p_level, p_strict_path+ '\', Name, p_pt_data);
                                  end;
                            end;
                      end;
                    end // change the dir
                  else begin
                      with l_entry do
                      begin
                        if e_dir_display_all_file in p_dir_handling_types
                          then display(l_spaces+ Format('%-20s %5s %10d', [Name, l_extension, Size]) );

                        l_extension:= ExtractFileExt(Name);
                        if UpperCase(l_extension)= UpperCase(p_extension)
                          then begin
                              if e_dir_display_file in p_dir_handling_types
                                then display(l_spaces+ Format('%-20s %5s %10d', [Name, l_extension, Size]) );

                              if Assigned(p_pr_handle_file) and (e_dir_handle_file in p_dir_handling_types)
                                then begin
                                    g_search_record:= l_entry;
                                    p_pr_handle_file(p_level, p_strict_path+ '\', Name, p_pt_data);
                                  end;
                            end;
                      end;
                    end;

                // -- get the next file of this sub dir
                l_result:= findnext(l_entry);
              end; // while not errors

              if p_level= 1
                then begin
                  end;
            end // found first
          else
            if e_dir_display_debug in p_dir_handling_types
              then display('no first');

        if e_dir_display_debug in p_dir_handling_types
          then display('< dir');
      end; // handle_all_files_recursive

    begin // u_handle_files_in_dirs
    end. // u_handle_files_in_dirs

rs

s

rs

s

rs

