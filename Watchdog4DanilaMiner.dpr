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
    FQuele := TThreadedQueue<String>.Create(10, 100, 100);
    FQueleBalance := TThreadedQueue<Double>.Create(10, 100, 100);;
    FBalance := 0;
    try
      SetConsoleCtrlHandler(@Handler, True);
      if not ConfigLoad(AConfigFilePath) then
      begin
        LogConsole('Error load config');
        Readln;
        exit;
      end;
      StartGetBalanceThread(FSettings.WalletAddress);
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
    FreeAndNil(FQuele);
    FreeAndNil(FQueleBalance);
  end;
end.
