unit uConcreteCommand;

interface

uses
  uCommand, uReceiver;

type
  { Concrete Command }
  TProgramas = class(TInterfacedObject, ICommand)
  private
    // Vari�vel para armazenar a refer�ncia do Receiver
    FReceiver: TReceiver;
  public
    constructor Create(Receiver: TReceiver);

    // Assinatura da Interface, m�todo de execu��o da opera��o
    procedure Execute;
  end;

implementation

{ TProgramas }

constructor TProgramas.Create(Receiver: TReceiver);
begin
  FReceiver := Receiver;
end;

procedure TProgramas.Execute;
begin
  FReceiver.ExtrairProgramas;
end;

end.
