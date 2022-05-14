unit UBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, JvExStdCtrls, JvListBox, JvDriveCtrls,
  JvComponentBase, JvSearchFiles, Mask, JvExMask, JvToolEdit, CheckLst;

type
  TFbackup = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    JvDir: TJvDirectoryEdit;
    JvFile: TJvSearchFiles;
    Label1: TLabel;
    ListBox1: TListBox;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    JvDirRes: TJvDirectoryEdit;
    Button2: TButton;
    ListBox2: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure JvDirAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure JvDirResAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fbackup: TFbackup;
  NovoDir, NovoDirRes : string;

implementation

uses UDMSERVER;

{$R *.dfm}

procedure TFbackup.Button1Click(Sender: TObject);
Var
I : Integer;
begin



if trim(JvDir.text) = '' then
   begin
   showmessage('Target folder missing.');
   exit;
   end;


if pos(Novodir,dm_server.dire) > 0 then
begin
  showmessage('You cannot select this folder');
  exit;
end;






try


if not SysUtils.DirectoryExists(Novodir+'\conf') then
    if not CreateDir(Novodir+'\conf') then
      raise Exception.Create('Cannot create folder '+Novodir+'\conf');

if not SysUtils.DirectoryExists(Novodir+'\dados') then
    if not CreateDir(Novodir+'\dados') then
      raise Exception.Create('Cannot create folder '+Novodir+'\dados');





JvFile.RootDirectory := dm_server.dire+'conf\';
JvFile.Search;
Listbox1.items := JvFile.Files;

for I:= 0 to ListBox1.Items.count - 1 do
  begin
  copyfile(Pchar(dm_server.dire+'conf\'+Listbox1.Items[i]), pchar(Novodir+'\conf\'+Listbox1.Items[i]),false)
  end;


JvFile.RootDirectory := dm_server.dire+'dados\';
JvFile.Search;
Listbox1.items := JvFile.Files;

for I:= 0 to ListBox1.Items.count - 1 do
  begin
  copyfile(Pchar(dm_server.dire+'dados\'+Listbox1.Items[i]), pchar(Novodir+'\dados\'+Listbox1.Items[i]),false)
  end;






except
showmessage('Backup failed');
exit;
end;

Showmessage('Backup done.');




end;

procedure TFbackup.Button2Click(Sender: TObject);
Var
I : Integer;
begin



if trim(JvDirRes.text) = '' then
   begin
   showmessage('Source folder missing.');
   exit;
   end;


if pos(NovodirRes,dm_server.dire) > 0 then
begin
  showmessage('You cannot select this folder');
  exit;
end;


try

JvFile.RootDirectory := NovodirRes+'\conf\';
JvFile.Search;
Listbox2.items := JvFile.Files;

for I:= 0 to ListBox2.Items.count - 1 do
  begin
  copyfile(Pchar(NovodirRes+'\conf\'+Listbox2.Items[i]), pchar(dm_server.dire+'conf\'+Listbox2.Items[i]),false)
  end;

JvFile.RootDirectory := NovodirRes+'\dados\';
JvFile.Search;
Listbox2.items := JvFile.Files;

for I:= 0 to ListBox2.Items.count - 1 do
  begin
  copyfile(Pchar(NovodirRes+'\dados\'+Listbox2.Items[i]), pchar(dm_server.dire+'dados\'+Listbox2.Items[i]),false)
  end;


except
showmessage('Restore failed');
exit;
end;

Showmessage('Restore done.');







end;

procedure TFbackup.JvDirResAfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
NovoDirRes := AName;
end;

procedure TFbackup.JvDirAfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
NovoDir := AName;
end;

end.
