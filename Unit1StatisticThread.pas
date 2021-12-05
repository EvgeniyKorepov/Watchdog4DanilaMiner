unit Unit1StatisticThread;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.SyncObjs,
  System.SysUtils,
  System.Net.HttpClient,
  System.Net.URLClient,
  System.NetEncoding,
  System.NetConsts,
  System.JSON;

const
  ConstHTTPClientConnectionTimeout = 5000;
  ConstHTTPClientResponseTimeout = 5000;

  ConstURLMain = 'https://korepov.com/ton/api/?request=';

type


  TStatistic = record
    Address : String;
    RigName : String;
    Hashrate : Double;
    HashrateAverage : Double;
    ShareCount : Int64;
  end;

  TStatisticThread = class(TThread)
  private
    FQueueStatistic: TThreadedQueue<TStatistic>;
    FHTTPClient: THTTPClient;
    procedure GetHTTP(var AStatistic: TStatistic);
    procedure Processing;
    function EncodeJSON(const AStatistic : TStatistic; out AQuery : String) : Boolean;
  protected
    procedure Execute; override;
    procedure HTTPClientValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest; const Certificate: TCertificate; var Accepted: Boolean);
  public
    constructor Create(out AQueueStatistic : TThreadedQueue<TStatistic>);
    destructor Destroy; override;
  end;

implementation

constructor TStatisticThread.Create(out AQueueStatistic : TThreadedQueue<TStatistic>);
begin
  FreeOnTerminate:=False;
  AQueueStatistic := TThreadedQueue<TStatistic>.Create(10, 10, 1000);
  FQueueStatistic := AQueueStatistic;

  FHTTPClient := THTTPClient.Create;
  FHTTPClient.ConnectionTimeout := ConstHTTPClientConnectionTimeout;
  FHTTPClient.ResponseTimeout := ConstHTTPClientResponseTimeout;
  FHTTPClient.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10586';
  FHTTPClient.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8';
  FHTTPClient.AcceptEncoding := 'gzip, deflate';
  FHTTPClient.AcceptLanguage := 'ru,en-US;q=0.8,en;q=0.6';
  FHTTPClient.ContentType := 'application/x-www-form-urlencoded';
  FHTTPClient.OnValidateServerCertificate := HTTPClientValidateServerCertificate;
  FHTTPClient.SecureProtocols := [THTTPSecureProtocol.TLS11, THTTPSecureProtocol.TLS12];

  inherited Create(FALSE);
end;

destructor TStatisticThread.Destroy;
begin
  if Assigned(FHTTPClient) then
    FreeAndNil(FHTTPClient);

  inherited Destroy;
end;

procedure TStatisticThread.Execute;
begin
  while Not Terminated do
    Processing;
end;

procedure TStatisticThread.Processing;
var AStatistic : TStatistic;
begin
  while FQueueStatistic.PopItem(AStatistic) = TWaitResult.wrSignaled do
  begin
    if Terminated then
      break;
    GetHTTP(AStatistic);
  end;
end;

procedure TStatisticThread.GetHTTP(var AStatistic: TStatistic);
Var HTTPResponse : IHTTPResponse;
    AQuery : String;
begin
  EncodeJSON(AStatistic, AQuery);
  AQuery := TNetEncoding.URL.Encode(AQuery);
  AQuery := ConstURLMain + AQuery;
  try
    HTTPResponse := FHTTPClient.Get(AQuery);

    if Assigned(HTTPResponse) and (HTTPResponse.StatusCode = 200) then
    begin
    end;
  except
  end;
end;

function TStatisticThread.EncodeJSON(const AStatistic : TStatistic; out AQuery : String) : Boolean;
var AJSON : TJSONObject;
begin
  Result := True;
  AJSON := TJSONObject.Create;
  try
    AJSON.AddPair('method', 'store');
    AJSON.AddPair('address', AStatistic.Address.Trim);
    AJSON.AddPair('rig_name', AStatistic.RigName.Trim);
    AJSON.AddPair('hashrate', TJSONNumber.Create(AStatistic.Hashrate));
    AJSON.AddPair('hashrate_average', TJSONNumber.Create(AStatistic.HashrateAverage));
    AJSON.AddPair('share_count', TJSONNumber.Create(AStatistic.ShareCount));
    AQuery := AJSON.ToString;
  finally
    FreeAndNil(AJSON);
  end;
end;


procedure TStatisticThread.HTTPClientValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest; const Certificate: TCertificate; var Accepted: Boolean);
begin
  Accepted:=True;
end;



end.




