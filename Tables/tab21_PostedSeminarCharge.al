table 50121 "CSD Posted Seminar Charge"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 6 - Lab 1
    //     - Created new table
    // Chapter 7 Lab 3-4
    Caption = 'Posted Seminar Charge';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "CSD Seminar Reg. Header";

        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Type"; Enum "Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            //OptionCaption = 'Resource,G/L Account';
            //OptionMembers = Resource,"G/L Account";


        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Resource)) Resource."No."
            else
            if (Type = const("G/L Account")) "G/L Account"."No.";


        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;


        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 2;
            MinValue = 0;


        }
        field(8; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
            Editable = false;
        }


        field(9; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(10; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(11; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = Field("No."))
            else
            "Unit of Measure".Code;


        }
        field(12; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(13; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(14; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(15; Registered; Boolean)
        {
            Caption = 'Registered';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {

    }


}

