unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, ZConnection, ZDataset, ZSqlMonitor, Forms,
  Controls, Graphics, Dialogs, DBCtrls, DBGrids, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    able_contaspago1: TBooleanField;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    ds_contas: TDataSource;
    lblEntrada: TLabel;
    lblSaida: TLabel;
    lblPagarVencido: TLabel;
    lblReceberVencido: TLabel;
    table_contasid: TLargeintField;
    table_contasnome1: TStringField;
    table_contastipo1: TStringField;
    table_contasvalor: TFloatField;
    table_contasvencimento: TDateField;
    ZConnection1: TZConnection;
    table_contas: TZTable;
    ZSQLMonitor1: TZSQLMonitor;
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCreate(Sender: TObject);
    procedure table_contasidChange(Sender: TField);
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

procedure TForm1.table_contasidChange(Sender: TField);
begin

end;

procedure TForm1.DBNavigator1BeforeAction(Sender: TObject; Button: TDBNavButtonType);
var
  entrada: double;
  saida: double;
  entrada_vencido: double;
  saida_vencido: double;
begin
  if Button = TDBNavButtonType.nbRefresh then
  begin
    table_contas.First;
    entrada := 0;
    saida := 0;
    entrada_vencido := 0;
    saida_vencido := 0;
    while not table_contas.EOF do
    begin
      if table_contas.FieldByName('tipo').AsString = 'Entrada' then
      begin
        entrada := entrada + table_contas.FieldByName('valor').AsFloat;
      end
      else
      begin
        saida := saida + table_contas.FieldByName('valor').AsFloat;
      end;
      if (Now > table_contas.FieldByName('vencimento').AsDateTime) and (not table_contas.FieldByName('pago').AsBoolean) then
      begin
        if table_contas.FieldByName('tipo').AsString = 'Entrada' then
        begin
          entrada_vencido := entrada_vencido + table_contas.FieldByName('valor').AsFloat;
        end
        else
        begin
          saida_vencido := saida_vencido + table_contas.FieldByName('valor').AsFloat;
        end;
      end;
      table_contas.Next;
    end;
    table_contas.First;
    lblEntrada.Caption := 'ENTRADA ' + FloatToStr(entrada);
    lblSaida.Caption := 'SAIDA ' + FloatToStr(saida);
    lblReceberVencido.Caption := 'RECEBER VENCIDO ' + FloatToStr(entrada_vencido);
    lblPagarVencido.Caption := 'PAGAR VENCIDO ' + FloatToStr(saida_vencido);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.


