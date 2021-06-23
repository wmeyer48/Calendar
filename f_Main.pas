unit f_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Advedit, AdvEdBtn, PlannerDatePicker, AdvSmoothCalendar, AdvSmoothCalendarGroup, advpanel, Vcl.ExtCtrls, advglowbutton, AdvOfficeButtons, GDIPFill;

type
  TForm1 = class(TForm)
    AdvPanel2: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    btnUpdateCalendar: TAdvGlowButton;
    Calendar: TAdvSmoothCalendarGroup;
    chkIncludeWeekends: TAdvOfficeCheckBox;
    dpEnd: TPlannerDatePicker;
    dpSelEnd: TPlannerDatePicker;
    dpSelStart: TPlannerDatePicker;
    dpStart: TPlannerDatePicker;
    fMain: TAdvPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnUpdateCalendarClick(Sender: TObject);
    procedure CalendarDateFill(Sender: TObject; AFill: TGDIPFill; AFont: TFont; Date: TDateTime; DateKind: TAdvSmoothCalendarDateKind);
    procedure FormShow(Sender: TObject);
  private
    FLoaded: Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.DateUtils;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Calendar.StartDate := EncodeDate(2021, 1, 1);
  Calendar.EndDate := EncodeDate(2021, 12, 31);
  dpStart.Date := EncodeDate(2021, 1, 1);
  dpEnd.Date := EncodeDate(2021, 12, 31);
  dpSelStart.Date := EncodeDate(2021, 6, 1);
  dpSelEnd.Date := EncodeDate(2021, 7, 1);
end;

procedure TForm1.btnUpdateCalendarClick(Sender: TObject);
begin
  Calendar.BeginUpdate;
  Calendar.Update;
  Calendar.EndUpdate;
end;

procedure TForm1.CalendarDateFill(Sender: TObject; AFill: TGDIPFill; AFont: TFont; Date: TDateTime; DateKind: TAdvSmoothCalendarDateKind);
begin
  if FLoaded then
  begin
    if (Date >= dpSelStart.Date) and (Date <= (dpSelEnd.Date + 1)) then
    begin
      if (DayOfTheWeek(Date) in [6..7]) and not chkIncludeWeekends.Checked then
        Exit;
      AFill.Color := clHighlight;
      AFont.Color := clHighlightText;
    end;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  FLoaded := True;
end;

end.
