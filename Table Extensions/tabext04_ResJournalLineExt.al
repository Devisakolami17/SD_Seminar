tableextension 50104 "CSD ResJournalLineExt" extends "Res. Journal Line"
{
    // chap 7-Lab 4-2
    fields
    {
        field(50100; "CSD Seminar No."; code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
            DataClassification = ToBeClassified;
        }
        field(50101; "CSD Seminar registration No."; code[20])
        {
            Caption = 'Seminar Registration No.';
            TableRelation = "CSD Seminar Reg. Header";
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}