pageextension 50103 "CSD ResourceLedgerEntryExt" extends "Resource Ledger entries"
{
    //Chapter 7 Lab 4-3
    layout
    {
        addlast(content)
        {


            field("CSD Seminar No."; Rec."CSD Seminar No.")
            {
                ApplicationArea = All;

            }
            field("CSD Seminar Registration No."; rec."CSD Seminar Registration No.")
            {
                ApplicationArea = All;
            }



        }
    }



}