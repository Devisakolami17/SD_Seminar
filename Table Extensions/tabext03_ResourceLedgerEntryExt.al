tableextension 50103 "CSD ResourceLedgerEntryExt" extends "Res. Ledger entry"
{
    // Chap 7 - Lab 4-1
    fields
    {
        field(50100; "CSD Seminar No."; code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
            DataClassification = ToBeClassified;

        }
        field(50101; "CSD Seminar Registration No."; code[20])
        {
            Caption = 'Seminar Registration No.';
            TableRelation = "CSD Seminar Reg. Header";
            DataClassification = ToBeClassified;

        }

    }


}