unit SSE.Controller;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  MVCFramework,
  MVCFramework.Serializer.Commons,
  MVCFramework.SSEController,
  Message.DTO;

var
  GMessage: string;

type
  [MVCPath('/listen')]
  TSSEController = class(TMVCSSEController)
  private
    LLastMessage: string;
    function GetServerSentEvents(const LastEventID: string): TMVCSSEMessages; override;

  end;

implementation

uses
  System.DateUtils;

function TSSEController.GetServerSentEvents(const LastEventID: string): TMVCSSEMessages;
begin
  inherited;
  var SSEMessage: TSSEMessage;

  if GMessage <> LLastMessage then
  begin
    LLastMessage := GMessage;
    if LastEventID.IsEmpty then
      SSEMessage.Id := IntToStr(1)
    else
      SSEMessage.Id := IntToStr(LastEventID.ToInteger + 1);

    SSEMessage.event := 'message';
    SSEMessage.data := GMessage;
    Result := Result + [SSEMessage];
  end;
end;

end.

