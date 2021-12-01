program Watchdog4DanilaMiner;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Generics.Collections,
  System.IOUtils,
  Winapi.Windows,
  UnitHelper in 'UnitHelper.pas';

var AWorkDir : String;
    AConfigFilePath : String;
begin
  try
    FSettings.HashrateList := THashrateList.Create;
    FSettings.HashFoundCount := 0;
    FFormatSettings := TFormatSettings.Create;
    try
      SetConsoleCtrlHandler(@Handler, True);
      if not ConfigLoad(AConfigFilePath) then
      begin
        LogConsole('Error load config');
        Readln;
        exit;
      end;
      LogConsole(GetBuildInfoAsString + ' , donate EQAIxel94QQBAiArH5taFYL0Lwntnhk79-AmcA23BvQsFUtc');
      SetConsoleTitle(PChar(GetBuildInfoAsString  + ' use config ' + AConfigFilePath));
      AWorkDir := TPath.GetDirectoryName(FSettings.MinerFilePath);
      repeat
        StartMiner(FSettings.MinerFilePath + ' run ' + FSettings.MinerParams + ' ' + FSettings.PoolUrls[FSettings.PoolID] + ' ' + FSettings.WalletAddress, AWorkDir);
        Sleep(100);
      until False;
    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;
  finally
    StopMiner;
    FreeAndNil(FSettings.HashrateList);
  end;
end.
