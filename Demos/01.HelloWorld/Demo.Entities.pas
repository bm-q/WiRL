unit Demo.Entities;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  /// <summary>
  ///   Simple Entity to show the automatic conversion to/from JSON
  /// </summary>
  TPerson = class
  private
    FName: string;
    FAge: Integer;
  public
    property Name: string read FName write FName;
    property Age: Integer read FAge write FAge;
  end;

  TPersonList = class(TObjectList<TPerson>);

  TOrderProposal = class
  private
    FArticle: string;
    FDescription: string;
    FDueDate: TDateTime;
    FQuantity: Double;
  public
    property Article: string read FArticle write FArticle;
    property Description: string read FDescription write FDescription;
    property DueDate: TDateTime read FDueDate write FDueDate;
    property Quantity: Double read FQuantity write FQuantity;
  end;

  TOrder = class(TOrderProposal)
  private
    FID: Integer;
  public
    property ID: Integer read FID write FID;
  end;

implementation

end.
