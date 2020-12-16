unit uConcreteCommand;

interface

uses
  uCommand, uReceiver;

type
  { Concrete Command }
  TProgramas = class(TInterfacedObject, ICommand)
  private
    // Variável para armazenar a referência do Receiver
    FReceiver: TReceiver;
  public
    constructor Create(Receiver: TReceiver);

    // Assinatura da Interface, método de execução da operação
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
