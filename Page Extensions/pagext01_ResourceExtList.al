pageextension 50101 "CSD ResourceListExt" extends "Resource List"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 Lab 1.3
{
    layout
    {
        modify(Type)
        {
            Visible = Showtype;
        }

        addafter("Type")
        {
            field("CSD Resource Type"; Rec."CSD Resource Type")
            {
                ApplicationArea = all;
            }
            field("CSD Maximum Participants"; Rec."CSD Maximum Participants")
            {
                Visible = ShowMaxField;
                ApplicationArea = all;

            }

        }


    }

    trigger OnOpenPage()
    begin
        ShowType := (Rec.GetFilter(Type) = '');
        ShowMaxField := (Rec.GetFilter(Type) = format(Rec.Type::Machine));
    end;

    var
        [InDataSet]
        ShowMaxField: Boolean;

        [InDataSet]
        Showtype: Boolean;

}