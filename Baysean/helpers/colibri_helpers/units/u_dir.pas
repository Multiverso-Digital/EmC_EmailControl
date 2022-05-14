// 019 u_dir
// 25 mar 2008

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_dir;
  interface
    uses Classes, FileCtrl;

    procedure remove_double_slashes(var pv_string: String);
    function f_with_one_slash_at_beginning(p_string: String): String;
    function f_with_ending_slash(p_string: String): String;
    function f_with_beginning_and_ending_slash(p_string: String): String;
    function f_without_ending_slash(p_string: String): String;
    function f_without_starting_slash(p_string: String): String;

    function f_erase_directory_files(p_the_path: string): Boolean;

    procedure separate_directory_and_file(var pv_directory, pv_file: String);
    function f_last_path_segment(p_path: String): String;
    function f_delete_last_path_segment(p_path: String): String;
    function f_segment(p_path, p_initial_path: String): String;
    function f_path_with_only_one_slash(p_string: String): String;
    function f_path_depth(p_path: String): Integer;
    function f_exe_path: String;
    procedure set_directory_listbox_directory(p_directory_listbox: tDirectoryListBox; p_directory: String);
    procedure set_file_listbox_directory(p_file_listbox: tFileListBox; p_directory: String);

    function f_create_path(p_path: String): Boolean;
    function f_check_path(p_path: String): Boolean;

    function f_non_file_path_name(p_path_name: String): String;
    function f_is_normalized_path_name(p_path_name: String): Boolean;
    function f_normalize_path_name(p_path_name: String): String;

    function f_folder_contains_extension(p_path: String; p_extension: String): Boolean;
    function f_folder_contains_sub_folder(p_path: String; p_sub_folder: String): Boolean;

    function f_folder_file_count(p_path: String): Integer;
    function f_folder_file_name(p_path: String; p_file_index: Integer): String;

    function f_last_valid_path(p_path: String): String;
    procedure display_last_valid_path(p_path: String);
    function f_contains_dot_dot(p_path: String): Boolean;
    function f_contains_drive(p_path: String): Boolean;

  implementation
    uses SysUtils, Forms
        , u_c_display, u_file, u_strings, u_characters;

    procedure remove_double_slashes(var pv_string: String);
      var l_index: Integer;
          l_result: String;
      begin
        l_result:= '';
        l_index:= 1;
        while l_index<= Length(pv_string) do
        begin
          if pv_string[l_index]= '\'
            then begin
                l_result:= l_result+ pv_string[l_index];
                Inc(l_index);
                while (l_index<= Length(pv_string)) and (pv_string[l_index]= '\') do
                  Inc(l_index);
              end
            else begin
                l_result:= l_result+ pv_string[l_index];
                Inc(l_index);
              end;
        end; // while l_index

        pv_string:= l_result;
      end; // remove_double_slashes

    function f_with_one_slash_at_beginning(p_string: String): String;
      begin
        if Length(p_string)> 0
          then begin
              Result:= p_string;
              while (Length(Result)> 0) and (Result[1]= '\') do
                delete(Result, 1, 1);
              Result:= '\'+ Result;
            end
          else Result:= '\';
      end; // f_with_one_slash_at_beginning

    function f_with_ending_slash(p_string: String): String;
      var l_length, l_index: Integer;
      begin
        l_length:= Length(p_string);
        if l_length= 0
          then Result:= '\'
          else begin
              Result:= p_string;

              // -- remove all ending \
              l_index:= l_length;
              while (l_index>= 1) and (Result[l_index]= '\') do
                dec(l_index);
              SetLength(Result, l_index);

              Result:= Result+ '\';
            end;
      end; // f_with_ending_slash

    function f_with_beginning_and_ending_slash(p_string: String): String;
      begin
        Result:= f_with_one_slash_at_beginning(p_string);
        Result:= f_with_ending_slash(Result);
      end; // f_with_beginning_and_ending_slash

    function f_without_ending_slash(p_string: String): String;
      var l_length, l_index: Integer;
      begin
        l_length:= Length(Trim(p_string));
        if l_length= 0
          then Result:= ''
          else begin
              Result:= p_string;

              // remove all ending \
              l_index:= l_length;
              while (l_index> 1) and (Result[l_index]= '\') do
                dec(l_index);
              SetLength(Result, l_index);
            end;
      end; // f_without_ending_slash

    function f_without_starting_slash(p_string: String): String;
      begin
        if Length(p_string)> 0
          then begin
              Result:= p_string;
              while (Length(Result)> 0) and (Result[1]= '\') do
                delete(Result, 1, 1);
            end;
      end; // f_without_starting_slash

    procedure separate_directory_and_file(var pv_directory, pv_file: String);
      var l_complete_name, l_path, l_name: String;
      begin
        l_complete_name:= pv_directory+ f_with_one_slash_at_beginning(pv_file);
        l_path:= ExtractFilePath(l_complete_name);
        l_name:= ExtractFileName(l_complete_name);
        pv_directory:= l_path;
        pv_file:= l_name;
      end; // separate_directory_and_file

    function f_path_with_only_one_slash(p_string: String): String;
      var l_index: Integer;
          l_previous: Char;
      begin
        Result:= '';
        l_previous:= ' ';
        for l_index:= 1 to Length(p_string) do
        begin
          if (p_string[l_index]<> '\') or (p_string[l_index]= '\') and (l_previous<> '\')
            then Result:= Result+ p_string[l_index];
          l_previous:= p_string[l_index];
        end;
      end; // f_path_with_only_one_slash

    function f_last_path_segment(p_path: String): String;
      var l_path: String;
          l_length, l_index: Integer;
      begin
        l_path:= f_path_with_only_one_slash(p_path);

        l_length:= Length(l_path);
        if l_length= 0
          then Result:= ''
          else begin
              if l_path[l_length]= '\'
                then l_index:= l_length- 1
                else l_index:= l_length;

              Result:= '';
              while (l_index>= 1) and (l_path[l_index]<> '\') do
              begin
                Result:= l_path[l_index]+ Result;
                Dec(l_index);
              end;
            end;
      end; // f_last_path_segment

    function f_delete_last_path_segment(p_path: String): String;
      var l_path: String;
          l_length, l_index: Integer;
      begin
        l_path:= f_path_with_only_one_slash(p_path);

        l_length:= Length(l_path);
        if l_length= 0
          then Result:= ''
          else begin
              if l_path[l_length]= '\'
                then l_index:= l_length- 1
                else l_index:= l_length;

              while (l_index>= 1) and (l_path[l_index]<> '\') do
                Dec(l_index);
              Result:= Copy(l_path, 1, l_index);
            end;
      end; // f_delete_last_path_segment

    function f_segment(p_path, p_initial_path: String): String;
      begin
        Result:= f_remove_start_if_start_is_equal_to(LowerCase(p_path), LowerCase(p_initial_path));
      end; // f_segment

    function f_path_depth(p_path: String): Integer;
      var l_path: String;
          l_length, l_index: Integer;
      begin
        l_path:= f_path_with_only_one_slash(p_path);
        l_length:= Length(l_path);

        if l_length= 0
          then Result:= 0
          else begin
              if l_path[l_length]= '\'
                then l_index:= l_length- 1
                else l_index:= l_length;

              Result:= 0;
              for l_index:= 1 to l_length do
                if l_path[l_index]= '\'
                  then Inc(Result);
            end;
      end; // f_path_depth

    function f_erase_directory_files(p_the_path: string): Boolean;
        // -- erase all the files of a directory

      procedure erase_files_recursive(p_level: Integer; p_strict_path: String);
          // always filter with *.* (to find subdirectories ?)
          //   and check extension
        var l_entry: tSearchRec;
            l_result: Integer;
        begin
          // -- find the first entry and save it in l_entry
          l_result:= FindFirst(p_strict_path+ '\*.*', faAnyfile, l_entry);

          if l_result= 0
            then begin
                // -- skip . et .. at the beginning of every path
                if l_entry.Name= '.'
                  then begin
                      l_result:= FindNext(l_entry);
                    end;
                if (l_result= 0) and (l_entry.Name= '..')
                  then begin
                      l_result:= FindNext(l_entry);
                    end;

                while l_result= 0 do
                begin
                  if (l_entry.Attr and faDirectory)<> 0
                    then begin // -- recurse in the sub directory
                        with l_entry do
                        begin
                          if (Name<> '.') and (Name<> '..')
                            then begin
                                erase_files_recursive(p_level+ 1,
                                    p_strict_path+ '\'+ Name);
                              end;
                        end;
                      end // change the dir
                    else begin
                        with l_entry do
                        begin
                          // display('erase '+ p_strict_path+ '\'+ Name);
                          // if p_display
                          //  then display(f_spaces(p_level* 2+ 2)+ '-'+ Name);

                          f_erase(p_strict_path+ '\'+ Name)
                        end;
                      end;

                  // -- the next file of this sub dir
                  l_result:= findnext(l_entry);
                end; // while not errors
              end; // found first

          FindClose(l_entry);
        end; // erase_files_recursive

      begin // f_erase_directory_files
        if not DirectoryExists(p_the_path)
          then begin
              display('no_dir '+ p_the_path);
              Result:= False;
              Exit;
            end;

        p_the_path:= f_without_ending_slash(p_the_path);

        erase_files_recursive(0, p_the_path);

        Result:= True;
      end; // f_erase_directory_files

    function f_exe_path: String;
      begin
        Result:= ExtractFilePath(Application.ExeName);
      end; // f_exe_path

    procedure set_directory_listbox_directory(p_directory_listbox: tDirectoryListBox; p_directory: String);
      begin
        if DirectoryExists(p_directory)
          then p_directory_listbox.Directory:= p_directory
          else begin
              display('DirectoryListbox_no_dir '+ p_directory);
              check_path_and_name(p_directory);
            end;
      end; // set_directory_listbox_directory

    procedure set_file_listbox_directory(p_file_listbox: tFileListBox; p_directory: String);
      begin
        if DirectoryExists(p_directory)
          then p_file_listbox.Directory:= p_directory
          else begin
              display('FileListbox_no_dir '+ p_directory);
              check_path_and_name(p_directory);
            end;
      end; // set_file_listbox_directory

    function f_create_path(p_path: String): Boolean;
        // -- true if did create
        // -- exception if contains "."
        // --   C:\data_download\browser\trial_1\www.209software.com\cgi-bin\textbtns.exe\transparent.jpg
      // var l_raise: Boolean;
      begin
        If FileExists(p_path)
          then begin
              display_bug_halt('already_file_with_this_name '+ p_path);
            end;

        if not DirectoryExists(p_path)
          then begin
              // display('force '+ p_path);
              Try
                ForceDirectories(p_path);
              except
                on e: Exception do
                  begin
                    display(e.Message);
                    display_bug_halt('could_not_create_path_1 >'+ p_path+ '< '+ IntToStr(Length(p_path)));
                  end;
              end;

              if not DirectoryExists(p_path)
                then display_bug_halt('could_not_create_path >'+ p_path+ '< '+ IntToStr(Length(p_path)));
              Result:= true;
            end
          else Result:= False;
      end; // f_create_path

    function f_check_path(p_path: String): Boolean;
      var l_index: Integer;
          l_path, l_name: String;
      begin
        Result:= True;
        if DirectoryExists(p_path)
          then begin
              exit;
            end;

        l_path:= f_with_ending_slash(Trim(p_path));

        l_name:= '';

        for l_index:= 1 to Length(l_path) do
        begin
          if l_path[l_index]= '\'
            then begin
                if Not DirectoryExists(l_name)
                  then begin
                      display('*** check_name_NO ');
                      display(' >'+ l_name+ '<');
                      Result:= False;
                      exit;
                    end;
              end;

          l_name:= l_name+ l_path[l_index];
        end; // for l_index
      end; // f_check_path

    function f_non_file_path_name(p_path_name: String): String;
        // -- whant to use ForceDirectories. Must be sure that a file
        // --  with a similar name does not already exist
        // --  insert a _, but not additional \ level
      const k_display= False;
      var // l_ending_slash: String;
          l_index, l_length: Integer;
      begin
        Result:= p_path_name;

        If FileExists(f_without_ending_slash(Result))
          then begin
              l_length:= Length(p_path_name);
              l_index:= l_length;
              while (l_index>= 1) and (Result[l_index]= '\') do
                Dec(l_index);
              Inc(l_index);  

              if k_display
                then display('non_file '+ IntToStr(l_index));

              Repeat
                Insert('_', Result, l_index);
              until Not FileExists(f_without_ending_slash(Result));
            end
      end; // f_non_file_path_name

(*
    function f_check_path(p_path: String): Boolean;
      var l_index: Integer;
          l_path, l_name: String;
      begin
        Result:= True;
        if DirectoryExists(p_path)
          then begin
              exit;
            end;

        l_path:= f_with_ending_slash(Trim(p_path));
        // display(' >'+ l_path+ '<');

        l_name:= '';

        for l_index:= 1 to Length(l_path) do
        begin
          if l_path[l_index]= '\'
            then begin
                // display(l_name);

                if Not DirectoryExists(l_name)
                  then begin
                      display('*** check_name_NO ');
                      display(' >'+ l_name+ '<');
                      Result:= False;
                      exit;
                    end;
              end;

          l_name:= l_name+ l_path[l_index];
        end; // for l_index
      end; // f_check_path
*)
    function f_is_normalized_path_name(p_path_name: String): Boolean;
        // -- only 'a'..'z', '_', '0'..'9', '\', '/', ':' if path
      const k_display= True;
      var l_colon_position: Integer;
          l_index: Integer;
      begin
        Result:= False;

        l_colon_position:= Pos(':', p_path_name);
        if (l_colon_position<= 0) or (l_colon_position= 2)
          then begin
              for l_index:= 1 to Length(p_path_name) do
                if not (
                         (p_path_name[l_index] in (k_letters+ k_digits+ ['_', ' ', '\', '/', '.', '-', '~']))
                         or
                         (l_colon_position= 2) and (p_path_name[l_index]= ':')
                       )
                  then begin
                      if k_display
                        then display('pos '+ IntToStr(l_index)+ ' '+ p_path_name[l_index]);
                      Exit;
                    end;
              Result:= True;
            end
          else
            if k_display
              then display('pos_ix '+  IntToStr(l_colon_position)) ;
      end; // f_is_normalized_path_name

    function f_normalize_path_name(p_path_name: String): String;
        // -- also replace %nn with an ascii
      var l_colon_position: Integer;
          l_index: Integer;
      begin
        Result:= f_replace_percent_nn(p_path_name);

        l_colon_position:= Pos(':', Result);
        if l_colon_position= 1
          then Result[1]:= '_';

        l_colon_position:= Pos(':', Result);
        if l_colon_position> 2
          then begin
              for l_index:= 3 to Length(Result) do
                if Result[l_index]= ':'
                  then Result[l_index]:= '_';
            end;

        for l_index:= 1 to Length(Result) do
        begin
          if not (Result[l_index] in (k_letters+ k_digits+ ['_', ' ', '\', '/', ':', '.', '-', '~']))
            then Result[l_index]:= '_';
        end; // while l_index
      end; // f_normalize_path_name

    function f_folder_contains_extension(p_path: String; p_extension: String): Boolean;
      var l_path: String;
          l_entry: tSearchRec;
          l_result: Integer;
          l_extension: String;
      begin
        Result:= False;
        p_extension:= LowerCase(p_extension);
        l_path:= f_without_ending_slash(p_path);

        // -- find the first entry and save it in l_entry
        l_result:= FindFirst(l_path+ '\*.*', faAnyfile, l_entry);

        if l_result= 0
          then begin
              // -- skip . et .. at the beginning of every path
              if l_entry.Name= '.'
                then begin
                    l_result:= FindNext(l_entry);
                  end;
              if (l_result= 0) and (l_entry.Name= '..')
                then begin
                    l_result:= FindNext(l_entry);
                  end;

              while l_result= 0 do
              begin
                if (l_entry.Attr and faDirectory)<> 0
                  then
                  else begin
                      l_extension:= ExtractFileExt(l_entry.Name);
                      if LowerCase(l_extension)= p_extension
                        then begin
                            Result:= True;
                            Break;
                          end;
                    end;

                // -- the next file of this sub dir
                l_result:= findnext(l_entry);
              end; // while not errors
            end; // found first
      end; // f_folder_contains_extension

    function f_folder_contains_sub_folder(p_path: String; p_sub_folder: String): Boolean;
      var l_path: String;
          l_entry: tSearchRec;
          l_result: Integer;
          l_sub_folder: String;
      begin
        Result:= False;
        l_path:= f_without_ending_slash(p_path);
        l_sub_folder:= LowerCase(p_sub_folder);

        // -- find the first entry and save it in l_entry
        l_result:= FindFirst(l_path+ '\*.*', faAnyfile, l_entry);

        if l_result= 0
          then begin
              // -- skip . et .. at the beginning of every path
              if l_entry.Name= '.'
                then begin
                    l_result:= FindNext(l_entry);
                  end;
              if (l_result= 0) and (l_entry.Name= '..')
                then begin
                    l_result:= FindNext(l_entry);
                  end;

              while l_result= 0 do
              begin
                if (l_entry.Attr and faDirectory)<> 0
                  then begin
                      if Pos(l_sub_folder, l_entry.Name)> 0
                        then begin
                            Result:= True;
                            Break;
                          end;
                    end;

                // -- the next file of this sub dir
                l_result:= findnext(l_entry);
              end; // while not errors
            end; // found first
      end; // f_folder_contains_sub_folder

    function f_folder_file_count(p_path: String): Integer;
      var l_path: String;
          l_entry: tSearchRec;
          l_result: Integer;
      begin
        Result:= 0;
        l_path:= f_without_ending_slash(p_path);

        // -- find the first entry and save it in l_entry
        l_result:= FindFirst(l_path+ '\*.*', faAnyfile, l_entry);

        if l_result= 0
          then begin
              // -- skip . et .. at the beginning of every path
              if l_entry.Name= '.'
                then l_result:= FindNext(l_entry);
              if (l_result= 0) and (l_entry.Name= '..')
                then l_result:= FindNext(l_entry);

              while l_result= 0 do
              begin
                if (l_entry.Attr and faDirectory)<> 0
                  then
                  else Inc(Result);

                // -- the next file of this sub dir
                l_result:= findnext(l_entry);
              end; // while not errors
            end; // found first
      end; // f_folder_file_count

    function f_folder_file_name(p_path: String; p_file_index: Integer): String;
      var l_path: String;
          l_entry: tSearchRec;
          l_result: Integer;
          l_file_index: Integer;
      begin
        Result:= '';
        l_file_index:= 0;
        l_path:= f_without_ending_slash(p_path);

        // -- find the first entry and save it in l_entry
        l_result:= FindFirst(l_path+ '\*.*', faAnyfile, l_entry);

        if l_result= 0
          then begin
              // -- skip . et .. at the beginning of every path
              if l_entry.Name= '.'
                then l_result:= FindNext(l_entry);
              if (l_result= 0) and (l_entry.Name= '..')
                then l_result:= FindNext(l_entry);

              while l_result= 0 do
              begin
                if (l_entry.Attr and faDirectory)<> 0
                  then
                  else begin
                      if l_file_index= p_file_index
                        then begin
                            Result:= l_entry.Name;
                            Break;
                          end;
                      Inc(l_file_index);
                    end;

                // -- the next file of this sub dir
                l_result:= findnext(l_entry);
              end; // while not errors
            end; // found first
      end; // f_folder_file_name

    function f_last_valid_path(p_path: String): String;
      var l_index: Integer;
          l_path, l_name: String;
          // l_file_name,
      begin
        if DirectoryExists(p_path)
          then begin
              Result:= p_path;
              exit;
            end;

        Result:= '';
        l_path:= ExtractFilePath(p_path);
        l_name:= '';

        for l_index:= 1 to Length(l_path) do
        begin
          if l_path[l_index]= '\'
            then begin
                if DirectoryExists(l_name)
                  then begin
                      Result:= l_name;
                      Exit;
                    end
                  else Break;
              end;

          l_name:= l_name+ l_path[l_index];
        end;
        Result:= Result+ '\';
      end; // f_last_valid_path

    procedure display_last_valid_path(p_path: String);
      var l_last_valid_path: String;
          l_path: String;
          l_entry: tSearchRec;
          l_result: Integer;
      begin
        l_last_valid_path:= f_last_valid_path(p_path);

        l_path:= f_without_ending_slash(l_last_valid_path);

        // -- find the first entry and save it in l_entry
        l_result:= FindFirst(l_path+ '\*.*', faAnyfile, l_entry);

        if l_result= 0
          then begin
              // -- skip . et .. at the beginning of every path
              if l_entry.Name= '.'
                then l_result:= FindNext(l_entry);
              if (l_result= 0) and (l_entry.Name= '..')
                then l_result:= FindNext(l_entry);

              while l_result= 0 do
              begin
                if (l_entry.Attr and faDirectory)<> 0
                  then display('['+ l_entry.Name+ ']')
                  else display(l_entry.Name);

                // -- the next file of this sub dir
                l_result:= findnext(l_entry);
              end; // while not errors
            end; // found first
      end; // display_last_valid_path

    function f_contains_dot_dot(p_path: String): Boolean;
      begin
        Result:= Pos('..\', p_path)> 0
      end; // f_contains_dot_dot

    function f_contains_drive(p_path: String): Boolean;
        // -- "c:\xxx"
      begin
        Result:= (Length(p_path)> 3)
          and (Upcase(p_path[1]) in ['A'..'Z'])
          and (p_path[2]= ':')
          and (p_path[3]= '\');
      end; // f_contains_drive

    end.




