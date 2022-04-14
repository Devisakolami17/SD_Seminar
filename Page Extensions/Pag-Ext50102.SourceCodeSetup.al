pageextension 50102 "CSD SourceCodeSetup" extends "Source Code Setup"
{
    layout
    {



        addafter("Cost Accounting")
        {
            group("CSD SemnarGroup")
            {
                Caption = 'Seminar';
                field(Seminar; Rec."CSD Seminar")
                {

                }
            }
        }

    }
}
