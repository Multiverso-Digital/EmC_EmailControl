Unit MultipleInstancePrevention;

Interface

Uses Forms, Windows;

Type
  TMultipleInstance = Class(TObject)
  Public
    Function IsAllreadyStarted(UniqueID: String) : Boolean;
    Function ShowApplication(UniqueID: String) : Boolean;
    Procedure SetAppHandle(UniqueID: String; AppHandle: THandle);
  End;

Var
  MultipleInstance : TMultipleInstance;

Implementation


Function GetAppHandle(UniqueID: String) : THandle;
Var
  MapHandle : THandle;
  MapData   : Pointer;
  MustInit  : Boolean;

Begin
   Result := 0;

   MapHandle := CreateFileMapping($FFFFFFFF, NIL, PAGE_READWRITE, 0, SizeOf(THandle), pChar(UniqueID));
   IF (MapHandle <> 0) Then
   Begin
      MustInit := (GetLastError() <> ERROR_ALREADY_EXISTS);

      MapData := MapViewOfFile(MapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
      IF (Assigned(MapData)) Then
      Begin
         IF (MustInit) Then
         Begin
            Result := 0;
            Try
              Move(Result, MapData^, SizeOf(THandle))
            Except
            End;
         End
          Else
           Begin
              Try
                Move(MapData^, Result, SizeOf(THandle));
              Except
                Result := 0;
              End;
           End;
         //
      End;
   End;
End;

Procedure TMultipleInstance.SetAppHandle(UniqueID: String; AppHandle: THandle);
Var
  MapHandle   : THandle;
  MapData     : Pointer;

Begin
   MapHandle := CreateFileMapping($FFFFFFFF, NIL, PAGE_READWRITE, 0, SizeOf(THandle), pChar(UniqueID));
   IF (MapHandle <> 0) Then
   Begin
      MapData := MapViewOfFile(MapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
      IF (Assigned(MapData)) Then
      Begin
         Try
           Move(AppHandle, MapData^, SizeOf(THandle));
         Except
         End;
      End;
   End;
End;

Function TMultipleInstance.IsAllreadyStarted(UniqueID: String) : Boolean;
Var
  AppHandle : THandle;

Begin
   AppHandle := GetAppHandle(UniqueID);
   Result := (IsWindow(AppHandle)) and (AppHandle <> 0);
End;

Function TMultipleInstance.ShowApplication(UniqueID: String) : Boolean;
Var
  AppHandle : THandle;

Begin
   Result := False;

   AppHandle := GetAppHandle(UniqueID);
   IF (AppHandle <> 0) Then
   Begin
      Result := IsWindow(AppHandle);
      IF (Result) Then
      Begin
         ShowWindow(AppHandle, SW_SHOWNORMAL);
         SetForegroundWindow(AppHandle);
         BringWindowToTop(AppHandle);
      End;
   End;
End;

Initialization
  MultipleInstance := TMultipleInstance.Create;

Finalization
  IF (Assigned(MultipleInstance)) Then MultipleInstance.Free;

End.


