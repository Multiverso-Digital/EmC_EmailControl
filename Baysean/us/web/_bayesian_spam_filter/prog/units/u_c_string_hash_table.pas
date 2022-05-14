// 003 u_c_string_hash_table
// 25 mar 2008

// -- (C) Felix John COLIBRI 2008
// -- documentation: http://www.felix-colibri.com

(*$r+*)

unit u_c_string_hash_table;
  interface
    uses Classes
        , u_c_basic_object
        ;

    const // -- debug
          k_no_probability= 777;
    type t_hash_data= record
                        m_hash_string: string;
                        m_hash_frequency: integer;
                        m_hash_probability: Double;
                      end;
         t_pt_hash_data= ^t_hash_data;

         c_hash_bucket=
             class(c_basic_object)
               _m_c_hash_data_list: TList;
               // -- stats
               _m_search_count: integer;

               constructor create_hash_bucket(p_name: String);

               function f_hash_data_count: Integer;
               function f_pt_hash_data(p_hash_index: Integer): t_pt_hash_data;

               function f_pt_add_hash_data(const pk_hash_string: String; p_integer: Integer): t_pt_hash_data;
               function f_pt_search_hash_data(const pk_hash_string: string): t_pt_hash_data;

               destructor Destroy; override;
             end; // c_hash_bucket

         c_hash_table=
             class(c_basic_object)
               _m_hash_type: integer;
               _m_hash_bucket_array: array of c_hash_bucket;
               _m_bucket_count: Integer;

               // -- stats
               m_search_count: integer;

               // -- manipulated by parser
               m_token_length, m_html_token_length: Integer;

               constructor create_hash_table(p_name: String;
                   p_requested_bucket_count: integer= 1023;
                   p_hash_type: Integer= 1);
               procedure _initialize_hash(p_bucket_count, p_hash_type: integer);

               function f_bucket_count: Integer;
               function f_c_bucket(p_bucket_index: Integer): c_hash_bucket;

               function f_string_hash_value(const pk_hash_string: string): integer;
               function f_pt_add_hash_data(const pk_hash_string: String; p_integer: Integer): t_pt_hash_data;

               function f_pt_add_hash_probability_data(const pk_hash_string: String;
                   p_integer: Integer; p_probability: Double): t_pt_hash_data;

               function f_pt_search_hash_data(const pk_search_string: string): t_pt_hash_data;

               function f_used_bucket_count: Integer;
               function f_hash_data_count: integer;

               function f_bucket_count_standard_deviation: double;
               procedure display_hash_table;

               destructor Destroy; override;
             end; // c_hash_table

         c_hash_iterator=
             Class(c_basic_object)
               _m_c_hash_table_ref: c_hash_table;
               _m_bucket_index: Integer;
               _m_hash_data_index: Integer;

               constructor create_hash_iterator(p_name: String;
                   p_c_hash_table_ref: c_hash_table);
               function f_move_next: Boolean;
               function f_pt_current_hash_data: t_pt_hash_data;
             end; // c_hash_iterator

  implementation
    uses Math, Windows // dWord
        , SysUtils, u_c_display;

    function f_nearest_prime(p_number: Cardinal): Cardinal;
        // -- used for setting the initial size

      function f_is_prime(p_number: Cardinal): Boolean;
        var I, J: Cardinal;
        begin
          if p_number< 4
            then Result:= p_number> 1
            else
              begin
                Result:= False;
                I:= (p_number mod 6);
                if (I= 1) or (I= 5)
                  then
                    begin
                      J:= round(sqrt(p_number));
                      I:= 5;
                      while I<= J do
                      begin
                        if (p_number mod I= 0)
                          then Exit;
                        if (p_number<> J) and (p_number mod (I+ 2)= 0)
                          then Exit;
                        inc(I, 6);
                      end;
                      Result:= True;
                    end;
              end;
        end; // f_is_prime

      var I: Cardinal;

      begin // f_nearest_prime
        if f_is_prime(p_number)
          then
            begin
              result:= p_number;
              exit
            end;

        if p_number= 4
          then
            begin
              result:= 5;
              exit
            end;

        I:= ((p_number+ 1) div 6)* 6- 1;
        repeat
          if f_is_prime(I+ 2)
            then
              begin
                inc(I, 2);
                break;
              end;
          if f_is_prime(I)
            then break;
          inc(I, 6);
        until false;
        Result:= I;
      end; // f_nearest_prime

    // -- c_hash_bucket

    constructor c_hash_bucket.create_hash_bucket(p_name: String);
      begin
        Inherited create_basic_object('');
        _m_c_hash_data_list:= TList.Create
      end; // create_hash_bucket

    function c_hash_bucket.f_hash_data_count: Integer;
      begin
        Result:= _m_c_hash_data_list.Count;
      end; // f_hash_data_count

    function c_hash_bucket.f_pt_hash_data(p_hash_index: Integer): t_pt_hash_data;
      begin
        Result:= t_pt_hash_data(_m_c_hash_data_list[p_hash_index]);
      end; // f_pt_hash_data

    function c_hash_bucket.f_pt_add_hash_data(const pk_hash_string: String; p_integer: Integer): t_pt_hash_data;
        // -- add a new bucket and initialize frequency
        // -- if this entry exists, exit
      begin
        Result:= f_pt_search_hash_data(pk_hash_string);
        if Result<> nil
          then exit;

        try
          New(Result);
          Result.m_hash_frequency:= p_integer;
          Result.m_hash_string:= pk_hash_string;
          _m_c_hash_data_list.Add(Result);
        finally
        end;
      end; // f_pt_add_hash_data

    function c_hash_bucket.f_pt_search_hash_data(const pk_hash_string: string): t_pt_hash_data;
      var l_bucket_max, l_bucket_index: integer;
          l_pt_hash_data: t_pt_hash_data;
      begin
        Result:= nil;
        l_bucket_max:= _m_c_hash_data_list.Count- 1;
        // -- stats
        _m_search_count:= 1;

        // -- linear search in the tList
        for l_bucket_index:= 0 to l_bucket_max do
        begin
          // -- stats for tuning
          inc(_m_search_count);

          l_pt_hash_data:= f_pt_hash_data(l_bucket_index);

          if pk_hash_string= l_pt_hash_data.m_hash_string
            then
              begin
                Result:= l_pt_hash_data;
                break
              end;
        end; // for l_bucket_index
      end; // f_pt_search_hash_data

    destructor c_hash_bucket.Destroy;
      var l_bucket_max, l_bucket_index: integer;
          l_pt_hash_data: t_pt_hash_data;
      begin
        l_bucket_max:= _m_c_hash_data_list.Count- 1;

        // -- empty each bucket
        for l_bucket_index:= 0 to l_bucket_max do
          Dispose(f_pt_hash_data(l_bucket_index));

        inherited;
      end; // Destroy

    // -- c_hash_table

    constructor c_hash_table.create_hash_table(p_name: String;
        p_requested_bucket_count: integer= 1023; p_hash_type: integer= 1);
        // -- Create hash
        // -- Find prime p_number nearest to the requested bucket count
      begin
        Inherited create_basic_object(p_name);
        _initialize_hash(f_nearest_prime(p_requested_bucket_count), p_hash_type);
      end; // Create

    procedure c_hash_table._initialize_hash(p_bucket_count, p_hash_type: integer);
        // -- create the buckets
      var l_bucket_index: integer;
      begin
        _m_bucket_count:= p_bucket_count;

        SetLength(_m_hash_bucket_array, _m_bucket_count);
        for l_bucket_index:= 0 to p_bucket_count- 1 do
          _m_hash_bucket_array[l_bucket_index]:= c_hash_bucket.create_hash_bucket('');

        _m_hash_type:= p_hash_type
      end; // _initialize_hash

    function c_hash_table.f_c_bucket(p_bucket_index: Integer): c_hash_bucket;
      begin
        Result:= _m_hash_bucket_array[p_bucket_index];
      end; // f_bucket(p_bucket_index: Integer);

    function c_hash_table.f_bucket_count: Integer;
      begin
        Result:= _m_bucket_count;
      end; // f_bucket_count

    function c_hash_table.f_string_hash_value(const pk_hash_string: string): integer;
      // -- compute the hash value of this string

      function ELFHashValue(const pk_hash_string: string): Integer;
        // ELF Hash formula
        var len: integer;
            hash, i, x: DWORD;
            P: PByte;
        begin
          Hash:= 0;
          len:= Length(pk_hash_string);
          P:= @pk_hash_string[1];
          for i:= 1 to len do
          begin
            Hash:= (Hash shl 4)+ (P^);
            x:= Hash and $F0000000;
            if (x<> 0)
              then Hash:= Hash xor (x shr 24);
            Hash:= Hash and (not x);
            inc(P)
          end;
          Result:= Hash mod DWORD(_m_bucket_count)
        end;

      begin // f_string_hash_value
        Result:= ELFHashValue(pk_hash_string);
      end; // f_string_hash_value

    function c_hash_table.f_pt_add_hash_data(const pk_hash_string: String; p_integer: Integer): t_pt_hash_data;
        // -- add a value to the hash structure
      var l_bucket_hash_index: integer;
      begin
        // -- find the bucket using the hashing calculation
        l_bucket_hash_index:= f_string_hash_value(pk_hash_string);
        // -- stats
        m_search_count:= _m_hash_bucket_array[l_bucket_hash_index]._m_search_count;

        // -- in this bucket, check whether this entry is present
        Result:= _m_hash_bucket_array[l_bucket_hash_index].f_pt_search_hash_data(pk_hash_string);

        // -- if no entry for this string in the bucket, add one
        if Result= nil
          then begin
              Result:= _m_hash_bucket_array[l_bucket_hash_index].f_pt_add_hash_data(pk_hash_string, p_integer);
            end
          else Inc(Result^.m_hash_frequency) ;

        // -- debug
        Result^.m_hash_probability:= k_no_probability;
      end; // f_pt_add_hash_data

    function c_hash_table.f_pt_add_hash_probability_data(const pk_hash_string: String;
        p_integer: Integer; p_probability: Double): t_pt_hash_data;
      var l_bucket_hash_index: integer;
      begin
        // -- find the bucket using the hashing calculation
        l_bucket_hash_index:= f_string_hash_value(pk_hash_string);
        Result:= _m_hash_bucket_array[l_bucket_hash_index].f_pt_add_hash_data(pk_hash_string, p_integer);
        Result^.m_hash_probability:= p_probability;
      end; // f_pt_add_hash_probability_data

    function c_hash_table.f_pt_search_hash_data(const pk_search_string: string): t_pt_hash_data;
      var l_bucket_hash_index: integer;
      begin
        // -- find the bucket using the hashing calculation
        l_bucket_hash_index:= f_string_hash_value(pk_search_string);
        // -- find the string in this bucket
        Result:= _m_hash_bucket_array[l_bucket_hash_index].f_pt_search_hash_data(pk_search_string)
      end; // f_pt_search_hash_data

    function c_hash_table.f_hash_data_count: integer;
        // -- count all data entries
      var l_bucket_index: Integer;
      begin
        Result:= 0;
        for l_bucket_index:= 0 to _m_bucket_count- 1 do
          Result:= Result+ _m_hash_bucket_array[l_bucket_index].f_hash_data_count
      end; // f_hash_data_count

    function c_hash_table.f_used_bucket_count: Integer;
        // -- count the buckets with some entries
      var l_bucket_index: Integer;
      begin
        Result:= 0;
        for l_bucket_index:= 0 to _m_bucket_count- 1 do
          if _m_hash_bucket_array[l_bucket_index].f_hash_data_count> 0
            then Inc(Result);
      end; // f_used_bucket_count

    // -- stats

    function c_hash_table.f_bucket_count_standard_deviation: double;
        // -- stats
      var l_bucket_count_array: array of double;
          i, j, total: integer;
      begin
        total:= f_hash_data_count;
        SetLength(l_bucket_count_array, total);
        j:= 0;
        for i:= 0 to _m_bucket_count- 1 do
          if f_c_bucket(i).f_hash_data_count> 0
            then
              begin
                l_bucket_count_array[j]:= f_c_bucket(i).f_hash_data_count;
                inc(j);
              end;

        if length(l_bucket_count_array)> 0
          then Result:= PopnStdDev(l_bucket_count_array)
          else Result:= 0;

        SetLength(l_bucket_count_array, 0);
      end; // f_bucket_count_standard_deviation

    procedure c_hash_table.display_hash_table;
      var l_bucket_index: Integer;
          l_hash_data_index: Integer;
          l_count: Integer;
      begin
        l_count:= 0;
        for l_bucket_index:= 0 to _m_bucket_count- 1 do
          with _m_hash_bucket_array[l_bucket_index] do
            for l_hash_data_index:= 0 to _m_c_hash_data_list.Count- 1 do //Length(_m_hash_bucket_array)- 1 do
            begin
              with f_pt_hash_data(l_hash_data_index)^ do
                display(Format('%7d %7d ', [l_count, m_hash_frequency])+ m_hash_string);
              Inc(l_count);
            end;
      end; // display_hash_table

    destructor c_hash_table.Destroy;
      var i: integer;
      begin
        for i:= 0 to _m_bucket_count- 1 do
          _m_hash_bucket_array[i].Free;
        SetLength(_m_hash_bucket_array, _m_bucket_count);
        inherited;
      end; // Destroy

    // -- c_hash_iterator

    constructor c_hash_iterator.create_hash_iterator(p_name: String;
        p_c_hash_table_ref: c_hash_table);
      begin
        Inherited create_basic_object('');
        _m_c_hash_table_ref:= p_c_hash_table_ref;

        // -- start "before" so that after f_move_next we will be ON the current entry
        _m_bucket_index:= -1;
      end; // create_hash_iterator

    function c_hash_iterator.f_move_next: Boolean;
      const k_debug= False;
        // -- true if on some valid hash entry.
        // -- _m_bucket_index and _hash_data_index then contain the current hash entry indexes
      begin
        Result:= False;

        with _m_c_hash_table_ref do
        begin
          if (_m_bucket_index>= _m_bucket_count)
              and (_m_hash_data_index>= _m_hash_bucket_array[_m_bucket_index].f_hash_data_count)
            then begin
                if k_debug
                  then display('  beyond_last');
                Exit;
              end;

          if _m_bucket_index= -1
            then begin
                // -- the very first cell: start just before
                _m_bucket_index:= 0;
                _m_hash_data_index:= -1;
              end;

          Inc(_m_hash_data_index);

          if k_debug
            then display(format('aft_inc   buck %4d ix %4d ', [_m_bucket_index, _m_hash_data_index]));

          if _m_hash_data_index< _m_hash_bucket_array[_m_bucket_index].f_hash_data_count
            then begin
                if k_debug
                  then display(format('ix_ok     buck %4d ix %4d ', [_m_bucket_index, _m_hash_data_index]));
                Result:= True;
              end
            else begin
                // -- find next non-empty bucket
                repeat
                  Inc(_m_bucket_index);
                until (_m_bucket_index>= _m_bucket_count) or (_m_hash_bucket_array[_m_bucket_index].f_hash_data_count> 0);

                if _m_bucket_index>= _m_bucket_count
                  then begin
                      if k_debug
                        then display(format('bey_buck  buck %4d ix %4d ', [_m_bucket_index, _m_hash_data_index]));
                      Exit;
                    end;

                // -- new bucket: start at the beginning again
                _m_hash_data_index:= 0;
                if _m_hash_data_index>= _m_hash_bucket_array[_m_bucket_index].f_hash_data_count
                  Then begin
                      if k_debug
                        then display(format('bey_data  buck %4d ix %4d ', [_m_bucket_index, _m_hash_data_index]));
                      Exit;
                    end;

                if k_debug
                  then display(format('ok_new_b  buck %4d ix %4d ', [_m_bucket_index, _m_hash_data_index]));
                Result:= True;
              end;
        end; // with _m_c_hash_table_ref
      end; // f_move_next

    function c_hash_iterator.f_pt_current_hash_data: t_pt_hash_data;
        // -- return the current hash entry. Only callable if f_move_next succeeded
      begin
        Result:= _m_c_hash_table_ref._m_hash_bucket_array[_m_bucket_index].f_pt_hash_data(_m_hash_data_index);
      end; // f_pt_move_next

    end.
