unit uFormulario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfFormulario = class(TForm)
    MemoProgramas: TMemo;
    LabelProgramas: TLabel;
    BitBtnExecutarComandos: TBitBtn;
    procedure BitBtnExecutarComandosClick(Sender: TObject);
  end;

var
  fFormulario: TfFormulario;

implementation

uses
  uCommand, uReceiver, uInvoker, uConcreteCommand;

{$R *.dfm}

procedure TfFormulario.BitBtnExecutarComandosClick(Sender: TObject);
var
  Receiver: TReceiver;
  Invoker: TInvoker;
begin
  // Remove os artigos antigos das extra��es anteriores
  DeleteFile(GetCurrentDir + '\Info\Programas.txt');

  // Cria o Receiver (objeto que cont�m a codifica��o das opera��es)
  Receiver := TReceiver.Create;

  // Cria o Invoker (objeto que armazena os comandos e os executa)
  Invoker := TInvoker.Create;
  try
    // Armazena o comando de extra��o de programas no Invoker
    Invoker.Add(TProgramas.Create(Receiver));

    // Solicita ao Invoker que execute todos os comandos armazenados
    Invoker.ExtrairInformacoes;
  finally
    // Libera os objetos da mem�ria
    FreeAndNil(Invoker);
    FreeAndNil(Receiver);
  end;

  // Limpa o conte�dos dos componentes TMemo
  MemoProgramas.Clear;

  // Carrega a lista de programas extra�dos
  if FileExists(GetCurrentDir + '\Info\Programas.txt') then
    MemoProgramas.Lines.LoadFromFile(GetCurrentDir + '\Info\Programas.txt');

end;

end.
