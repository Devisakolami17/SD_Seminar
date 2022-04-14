table 50131 "CSD Seminar Journal Line"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 1
    //     - Created new table
    // Hapi i pare 

    Caption = 'Seminar Journal Line';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
            DataClassification = ToBeClassified;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
            trigger OnValidate();
            begin
                Validate("Document Date", "Posting Date");

            end;

        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; "Entry Type"; Enum "Entry Type")
        {
            Caption = 'Entry Type';
            // OptionCaption = 'Registration,Cancelation';
            // OptionMembers = Registration,Cancelation;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
            DataClassification = ToBeClassified;
        }
        field(10; "Charge Type"; Enum "Charge Type")
        {
            Caption = 'Charge Type';
            DataClassification = ToBeClassified;
            // OptionCaption = 'Resource,G/L Account';
            // OptionMembers = Resource,"G/L Account";

        }
        field(11; Type; Enum Type)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;
        }
        field(13; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
        }
        field(14; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';
            DataClassification = ToBeClassified;
        }
        field(15; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact;
            DataClassification = ToBeClassified;
        }
        field(16; "Participant Name"; Text[50])
        {
            Caption = 'Participant Name';
            DataClassification = ToBeClassified;
        }
        field(17; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            InitValue = true;
            DataClassification = ToBeClassified;
        }
        field(18; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            TableRelation = Resource where(Type = const(Machine));
            DataClassification = ToBeClassified;
        }
        field(19; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            TableRelation = Resource where(Type = const(Person));
            DataClassification = ToBeClassified;
        }
        field(20; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(21; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = ToBeClassified;
        }
        field(22; "Res. Ledger Entry No."; Integer)
        {
            Caption = 'Res. Ledger Entry No.';
            TableRelation = "Res. Ledger Entry";
            DataClassification = ToBeClassified;
        }
        field(23; "Source Type"; Enum "Source Type ")
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            // OptionCaption = '" ,Seminar"';
            // OptionMembers = " ",Seminar;

        }
        field(24; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Seminar)) "CSD Seminar";
            DataClassification = ToBeClassified;

        }
        field(25; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
        }
        field(26; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
            DataClassification = ToBeClassified;
        }
        field(27; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = ToBeClassified;
        }
        field(28; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
        }
    }
    procedure EmptyLine(): Boolean; // si fillim shtuam Procedure 
    begin

        exit(("Seminar No." = '') AND (Quantity = 0));

    end;

}
