unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  capstr;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

type
  TRec = record
    s: string;
  end;

operator := (s: string) r: TRec;
begin
  result.s := s;
end;

operator := (i: integer) r: TRec;
begin
  result.s := inttostr(i);
end;

operator = (i: integer; r: TRec) b: boolean;
begin
  result := false;
  if strtoint(r.s) = i then result := true;
end;

operator = (r: TRec; i: integer) b: boolean;
begin
  result := false;
  if strtoint(r.s) = i then result := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
var r: TRec;
begin
  r := 'test';
  showmessage(r.s);
  r := 5;
  showmessage(r.s);
  if r = 5 then showmessage('equals 5');
  r := 6;
  if r = 5 then showmessage('still equals 5');
end;

operator := (s: string) cs: TCapStr;
begin
  result.data := s;
end;

operator := (i: integer) cs: TCapStr;
begin
  result.data := inttostr(i);
end;

operator = (s: string; cs: TCapStr) b: boolean;
begin
  result := false;
  if cs.data = s then result := true;
end;
{
operator + (s: string; cs: TCapStr) res: TCapStr;
begin
  addstr(s, @cs);
  result := cs;
end;
}
operator + (s: string; var cs: TCapStr) res: string;
begin
  endupdate(@cs);
//  addstr(s, @cs);
  result := s + cs.data;
end;

operator + (var cs: TCapStr; s: string) res: string;
begin
  addstr(s, @cs);
  endupdate(@cs);
  result := cs.data;
end;


operator + (var cs: TCapStr; s: string) res: TCapStr;
begin
  addstr(s, @cs);
  result := cs;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  buf, buf2: TCapStr;
  s: string;
begin
  resetbuf(@buf); // always reset before using capstring, if this was a built in type into the language this could be done automatically.
  addstr('test123', @buf); // add some data to the string
  addstr(' and testabc', @buf); // concat more data
  endupdate(@buf); // always clean up when done adding data
  showmessage(buf.data); // buf.data can be accessed as read only if we have called EndUpdate()
  s := '';
  s := buf + ' lalala';
  showmessage(s);
  s := 'tester123 ' + buf;
  showmessage(s);
  buf2 := 'tester123 ' + buf;
  showmessage(buf2.data);
end;



end.

