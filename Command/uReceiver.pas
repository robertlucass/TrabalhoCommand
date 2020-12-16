unit uReceiver;

interface

type
  { Receiver }
  TReceiver = class
  public
    procedure ExtrairProgramas;

  end;

implementation

uses
  Dialogs, Messages, Windows, TlHelp32, psAPI, SysUtils, Registry, Classes;

{ TReceiver }

procedure TReceiver.ExtrairProgramas;
const
  CHAVE_REGISTRO = 'Software\Microsoft\Windows\CurrentVersion\Uninstall\';
var
  Registro: TRegistry;
  Contador: integer;
  ListaChaves: TStringList;
  ListaProgramas: TStringList;
begin
  // Método responsável por extrair a lista de programas instalados
  Registro := TRegistry.Create;
  ListaChaves := TStringList.Create;
  ListaProgramas := TStringList.Create;
  try
    // Obtém a lista de chaves existentes no caminho do registro
    // que armazena as informações de programas instalados
    Registro.RootKey := HKEY_LOCAL_MACHINE;
    Registro.OpenKey(CHAVE_REGISTRO, False);
    Registro.GetKeyNames(ListaChaves);
    Registro.CloseKey;

    // Percorre a lista de chaves para acessar o valor do atributo "DisplayName"
    for Contador := 0 to Pred(ListaChaves.Count) do
    begin
      Registro.RootKey := HKEY_LOCAL_MACHINE;
      Registro.OpenKey(CHAVE_REGISTRO + ListaChaves[Contador], False);

      if Registro.ReadString('DisplayName') <> EmptyStr then
        // Adiciona o nome do programa na variável ListaProgramas
        ListaProgramas.Add(Registro.ReadString('DisplayName'));

      Registro.CloseKey;
    end;

    // Grava a lista de processos no arquivo "Programas.txt"
    ListaProgramas.SaveToFile(GetCurrentDir + '\Info\Programas.txt');
  finally
    // Libera os objetos da memória
    FreeAndNil(ListaProgramas);
    FreeAndNil(ListaChaves);
    FreeAndNil(Registro);
  end;
end;

end.
