table 50100 "CSD Seminar Setup"
//Lab 5.2 Task 1
{
    Caption = 'Seminar Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;

        }
        field(20; "Seminar Nos."; Code[20])
        {
            Caption = 'Seminar Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(30; "Seminar Registration Nos."; Code[30])
        {
            Caption = 'Seminar Registration Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(40; "Posted Seminar Reg. Nos."; Code[40])
        {
            Caption = 'Posted Seminar Reg. Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }



}