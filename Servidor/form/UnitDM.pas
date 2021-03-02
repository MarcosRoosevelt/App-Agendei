unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, uDWDataModule, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, uDWAbout, uRESTDWServerEvents,
  uDWJSONObject, uDWConsts, System.JSON, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait;

type
  Tdm = class(TServerMethodDataModule)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    EventsUsuario: TDWServerEvents;
    procedure ServerMethodDataModuleCreate(Sender: TObject);
    procedure EventsUsuarioEventsloginReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure ServerMethodDataModuleDestroy(Sender: TObject);
  private
    FConn   : TFDConnection;
  public

  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.EventsUsuarioEventsloginReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  FQuery  : TFDQuery;
  json    : TJSONObject;
begin

  Try

    FQuery := TFDQuery.Create(nil);
    FQuery.Connection := FConn;

    json := TJSONObject.Create;

    //verificação do parâmetro email
    if Params.ItemsString['email'].AsString = '' then
    begin
            //{"retorno":"erro..."}
            json.AddPair('retorno', 'Email não informado');
            Result := json.ToString;
            exit;
    end;

    Try

      FQuery.Close;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('SELECT * FROM TAB_USUARIO WHERE EMAIL=:EMAIL AND SENHA=:SENHA');
      FQuery.ParamByName('EMAIL').Value := params.ItemsString['email'].AsString;
      FQuery.ParamByName('SENHA').Value := Params.ItemsString['senha'].AsString;
      FQuery.Open;

      //caso a querey encontrar algo...
      if FQuery.RecordCount > 0 then
      begin
        json.AddPair('retorno', 'OK');
        //json.AddPair('id_usuario', QryLogin.FieldByName('id_usuario').AsString);
        json.AddPair('nome', FQuery.FieldByName('nome').AsString);
      end
      else
      json.AddPair('retorno', 'Email ou senha inválida');

      Result := json.ToString;

    Except
      on E:Exception do
      begin
        json.AddPair('retorno', E.Message);
        Result := json.ToString;
      end;

    End;
  Finally
    json.DisposeOf;
    FQuery.DisposeOf;
  End;

end;

procedure Tdm.ServerMethodDataModuleCreate(Sender: TObject);
begin

  FConn := TFDConnection.Create(nil);

  //conexao com o bd
  FConn.Params.Clear;
  FConn.LoginPrompt                := False;

  FConn.Params.DriverID            := 'FB';
  FConn.Params.Values['Protocol']  := 'TCPIP';

  FConn.Params.Values['Server']    := '127.0.0.1';

  FConn.Params.UserName            := 'SYSDBA';
  FConn.Params.Password            := 'masterkey';
  FConn.Params.Database            := 'C:\Delphi\Agendei\Servidor\DB\BANCO.FDB';

  FConn.Connected := true;

end;

procedure Tdm.ServerMethodDataModuleDestroy(Sender: TObject);
begin
  FConn.DisposeOf;
end;

end.
