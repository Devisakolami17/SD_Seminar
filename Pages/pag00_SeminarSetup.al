page 50100 "CSD Seminar Setup"
//Lab 5.2 Task 4

{
    PageType = Card;
    SourceTable = "CSD Seminar Setup";
    Caption = 'Seminar Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;



    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; Rec."Seminar Nos.")
                {
                    ApplicationArea = All;

                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.get then begin
            Rec.init;
            Rec.insert;
        end;

    end;
}