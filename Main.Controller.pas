unit Main.Controller;

interface

uses
  MVCFramework,
  MVCFramework.SSEController,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  SSE.Controller,
  Message.DTO;

type
  [MVCPath('/api')]
  TMainController = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/sendevent')]
    [MVCHTTPMethod([httpPOST])]
    procedure SendEvent;

  end;

implementation

uses
  System.SysUtils,
  MVCFramework.Logger,
  System.StrUtils;

procedure TMainController.Index;
begin
  //use Context property to access to the HTTP request and response
  Render('Hello DelphiMVCFramework World');
end;

procedure TMainController.SendEvent;
begin
  var LMessage := TMessageDTO.Create;
  LMessage := Context.Request.BodyAs<TMessageDTO>;
  if Assigned(LMessage) then
  begin
    LMessage.timestamp := now;
    SSE.Controller.GMessage := Format('{"timestamp":"%s", "data":{"author":"%s", "body": "%s"}}', [DateTimeToStr(LMessage.timestamp), LMessage.author, LMessage.body]);
    Render(HTTP_STATUS.OK, LMessage);
  end
  else
    Render(HTTP_STATUS.BadRequest, 'Bad Request');
end;

end.

