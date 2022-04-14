page 50106 "CSD Seminar Comment Sheet"
// Lab 5.3 Task 2
{
    PageType = List;
    SourceTable = "CSD Seminar Comment Line";
    Caption = 'Seminar Comment Sheet';
    UsageCategory = Lists;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;

                }
                field(Code; Rec.Code)
                {
                    Visible = false;
                    ApplicationArea = All;

                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }

            }
        }


    }
    trigger OnNewRecord(BelowxRec: Boolean)

    begin

        Rec.SetupNewLine;

    end;

}