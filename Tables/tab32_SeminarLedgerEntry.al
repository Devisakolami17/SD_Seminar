table 50132 "CSD Seminar Ledger Entry"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 1
    //     - Created new table

    Caption = 'Seminar Ledger Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }


        field(2; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Entry Type"; Enum "Entry Type")
        {
            Caption = 'Entry Type';
            DataClassification = ToBeClassified;

        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(8; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
            DataClassification = ToBeClassified;
        }
        field(9; "Charge Type"; enum "Charge Type")
        {
            Caption = 'Charge Type';
            DataClassification = ToBeClassified;
        }
        field(10; Type; Enum "Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(11; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;
        }
        field(12; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
        }
        field(13; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';
            DataClassification = ToBeClassified;
        }
        field(14; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact;
            DataClassification = ToBeClassified;
        }
        field(15; "Participant Name"; Text[50])
        {
            Caption = 'Participant Name';
            DataClassification = ToBeClassified;
        }
        field(16; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            InitValue = true;
            DataClassification = ToBeClassified;
        }
        field(17; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            TableRelation = Resource where(Type = const(Machine));
            DataClassification = ToBeClassified;
        }
        field(18; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            TableRelation = Resource where(Type = const(Person));
            DataClassification = ToBeClassified;
        }
        field(19; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
        }
        field(20; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = ToBeClassified;
        }
        field(21; "Res. Ledger Entry No."; Integer)
        {
            Caption = 'Res. Ledger Entry No.';
            TableRelation = "Res. Ledger Entry";
            DataClassification = ToBeClassified;
        }
        field(22; "Source Type"; Enum "Source Type ")
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;

        }
        field(23; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Seminar)) "CSD Seminar";
            DataClassification = ToBeClassified;
        }
        field(24; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
        }
        field(25; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
            DataClassification = ToBeClassified;
        }
        field(26; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = ToBeClassified;
        }
        field(27; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(28; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = user where("User Name" = field("USer ID"));

        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

}

