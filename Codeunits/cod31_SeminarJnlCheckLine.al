codeunit 50131 "CSD Seminar Jnl.-Check Line"
{
    //Chap 7 Lab 2-1
    TableNo = "CSD Seminar Journal Line";
    trigger OnRun()
    begin
        RunCheck(Rec);

    end;

    var
        GlSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        ClosingDateTxt: Label 'cannot be a closing date.';
        PostingDateTxt: Label 'is not withing your range of allowed posting date';

    procedure RunCheck(var SemJnlLine: Record "CSD Seminar Journal Line");
    var
        myInt: Integer;
    begin

        if SemJnlLine.EmptyLine then
            exit;
        SemJnlLine.TestField("Posting Date");
        SemJnlLine.TestField("Instructor Resource No.");
        SemJnlLine.TestField("Seminar No.");

        case SemJnlLine."Charge Type" of
            "Charge type"::Instructor:
                SemJnlLine.TestField("Instructor Resource No.");
            "Charge Type"::Room:
                SemJnlLine.TestField("Room Resource No.");
            "Charge Type"::Participant:
                SemJnlLine.TestField("Participant Contact No.");
        end;

        if SemJnlLine.Chargeable then
            SemJnlLine.TestField("Bill-to Customer No.");

        if SemJnlLine."Posting Date" = ClosingDate(SemJnlLine."Posting Date") then
            SemJnlLine.FieldError("Posting Date", ClosingDateTxt);

        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
            if UserId <> '' then
                if UserSetup.GET(USerId) then begin
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                end;
            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D)
            then begin
                GlSetup.GET;
                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";

            end;
            if AllowPostingTo = 0D then
                AllowPostingTo := DMY2Date(31, 12, 9999);
        end;
        if (SemJnlLine."Posting Date" < AllowPostingFrom) OR
        (SemJnlLine."Posting Date" > AllowPostingTo) then
            SemJnlLine.FieldError("Posting Date", PostingDateTxt);

        if (SemJnlLine."document Date" <> 0D) then
            if (SemJnlLine."Document Date" = ClosingDate(SemJnlLine."Document Date")) then
                SemJnlLine.FieldError("Document Date", PostingDateTxt);
    end;










}