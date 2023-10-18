unit Message.DTO;

interface

uses
  MVCFramework.Serializer.Commons;

type
  TMessageDTO = class
  private
    Fbody: string;
    Fauthor: string;
    Ftimestamp: TDateTime;
  public
    property author: string read Fauthor write Fauthor;
    property body: string read Fbody write Fbody;
    [MVCDoNotSerialize]
    property timestamp: TDateTime read Ftimestamp write Ftimestamp;
  end;

implementation

end.

