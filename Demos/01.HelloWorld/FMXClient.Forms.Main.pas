{******************************************************************************}
{                                                                              }
{       WiRL: RESTful Library for Delphi                                       }
{                                                                              }
{       Copyright (c) 2015-2019 WiRL Team                                      }
{                                                                              }
{       https://github.com/delphi-blocks/WiRL                                  }
{                                                                              }
{******************************************************************************}
unit FMXClient.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.MultiView, FMX.Memo,
  FMX.Controls.Presentation, FMX.Edit, FMX.ScrollBox,
  Generics.Collections;

type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    MainTabControl: TTabControl;
    HelloWorldTabItem: TTabItem;
    StringDemosTabItem: TTabItem;
    btnExecute: TButton;
    Memo1: TMemo;
    Layout1: TLayout;
    Layout2: TLayout;
    Edit1: TEdit;
    Label1: TLabel;
    btnEcho: TButton;
    Edit2: TEdit;
    Label2: TLabel;
    Layout3: TLayout;
    Edit3: TEdit;
    Label3: TLabel;
    btnReverse: TButton;
    Edit4: TEdit;
    Label4: TLabel;
    btnPost: TButton;
    procedure btnExecuteClick(Sender: TObject);
    procedure btnEchoClick(Sender: TObject);
    procedure btnReverseClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  FMXClient.DataModules.Main,
  WiRL.Core.Utils,
  WiRL.Rtti.Utils,
  WiRL.Client.Utils,
  WiRL.Core.JSON;

procedure TMainForm.btnEchoClick(Sender: TObject);
begin
  Edit2.Text := MainDataModule.EchoString(Edit1.Text);
end;

procedure TMainForm.btnReverseClick(Sender: TObject);
begin
  Edit4.Text := MainDataModule.ReverseString(Edit3.Text);
end;

procedure TMainForm.btnPostClick(Sender: TObject);
var
  LArray: TJSONArray;
begin
  LArray := TJSONArray.Create;
  try
    LArray.Add('Prova 1');
    LArray.Add('Prova 2');
    LArray.Add('Prova 3');

    MainDataModule.PostExampleResource.POST(
      procedure(AContent: TMemoryStream)
      var
        LWriter: TStreamWriter;
      begin
        LWriter := TStreamWriter.Create(AContent);
        try
          LWriter.Write(LArray.ToJSON);
          AContent.Position := 0;
        finally
          LWriter.Free;
        end;
      end
      ,
      procedure (AResponse: TStream)
      begin
        AResponse.Position := 0;

        ShowMessage('OK, ' + AResponse.Size.ToString() + ' bytes: ' + sLineBreak
          + StreamToString(AResponse));
      end
    );
  finally
    LArray.Free;
  end;
end;

procedure TMainForm.btnExecuteClick(Sender: TObject);
begin
  Memo1.Lines.Add(MainDataModule.ExecuteHelloWorld);
end;

end.
