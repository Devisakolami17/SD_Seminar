table 50104 "CSD Seminar Comment Line"
//Lab5.3 task 
// Lab 7.3 task 2
{

    Caption = 'Seminar Comment Line';
    DataClassification = ToBeClassified;
    LookupPageId = "CSD Seminar comment List";
    DrillDownPageId = "CSD Seminar Comment List";

    fields
    {
        field(10; "Table Name"; Enum "Table Name ")
        {
            Caption = 'Table Name';
            DataClassification = ToBeClassified;
        }
        field(20; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = ToBeClassified;
        }
        field(30; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = if ("Table Name" = const(Seminar)) "CSD Seminar"
            else
            if ("Table Name" = const(" Seminar Registration Header")) "CSD Seminar Reg. Header"
            else
            if ("Table Name" = const(" Posted Seminar Reg.Header")) "CSD Posted Seminar Reg. Header";


        }
        field(40; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(50; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(60; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(70; "Comment"; Text[80])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Table Name", "Document Line No.", "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure SetupNewLine()
    var
        SeminarCommentLine: Record "CSD Seminar Comment Line";
    begin
        SeminarCommentLine.SetRange("Table Name", "Table Name");
        SeminarCommentLine.SetRange("No.", "No.");
        SeminarCommentLine.SetRange("Document Line No.",
        "Document Line No.");
        SeminarCommentLine.SetRange("Date", WorkDate);
        if SeminarCommentLine.IsEmpty then
            Date := WorkDate;

    end;
}
