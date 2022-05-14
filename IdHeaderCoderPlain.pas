unit IdHeaderCoderPlain;

interface

//{$i IdCompilerDefines.inc}

uses
  IdGlobal, IdHeaderCoderBase, SysUtils;

type
  TIdHeaderCoderPlain = class(TIdHeaderCoder)
  public
    class function Decode(const ACharSet, AData: String): String; override;
    class function Encode(const ACharSet, AData: String): String; override;
    class function CanHandle(const ACharSet: String): Boolean; override;
  end;

implementation

class function TIdHeaderCoderPlain.Decode(const ACharSet, AData: String): String;
begin
  Result := AData;
end;

class function TIdHeaderCoderPlain.Encode(const ACharSet, AData: String): String;
begin
  Result := AData;
end;

class function TIdHeaderCoderPlain.CanHandle(const ACharSet: String): Boolean;
begin
  Result := TextStartsWith(Uppercase(ACharSet), 'ISO'); {do not localize}
  if Result then begin
    // 'ISO-2022-JP' is handled by TIdHeaderCoder2022JP
    Result := not TextIsSame(Uppercase(ACharSet), 'ISO-2022-JP'); {do not localize}
    Exit;
  end;
  if not Result then begin
    Result := TextStartsWith(Uppercase(ACharSet), 'WINDOWS'); {do not localize}
    if not Result then begin
      Result := TextStartsWith(Uppercase(ACharSet), 'KOI8'); {do not localize}
      if not Result then begin
        Result := TextStartsWith(Uppercase(ACharSet), 'GB2312'); {do not localize}
        if not Result then begin
          Result := TextIsSame(Uppercase(ACharSet), 'US-ASCII');
        end;
      end;
    end;
  end;
end;

initialization
  RegisterHeaderCoder(TIdHeaderCoderPlain);
finalization
  UnregisterHeaderCoder(TIdHeaderCoderPlain);

end.
