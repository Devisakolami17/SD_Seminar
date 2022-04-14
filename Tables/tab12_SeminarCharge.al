table 50112 "CSD Seminar Charge"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 6 - Lab 1
    //     - Created new table
    Caption = 'Seminar Charge';

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

            trigger OnValidate();
            var
                OldType: Enum "Type";
            begin
                if Type <> xRec.Type then begin
                    OldType := "Type";
                    Init;
                    Type := "OldType";
                end;
            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Resource)) Resource."No."
            else
            if (Type = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate();
            begin
                case Type of
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            Resource.TestField(Blocked, false);
                            Resource.TestField("Gen. Prod. Posting Group");
                            Description := Resource.Name;
                            "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                            "Unit of Measure Code" := Resource."Base Unit of Measure";
                            "Unit Price" := Resource."Unit Price";
                        end;
                    Type::"G/L Account":
                        begin
                            GLAccount.Get("No.");
                            GLAccount.CheckGLAcc();
                            GLAccount.TestField("Direct Posting", true);
                            Description := GLAccount.Name;
                            "Gen. Prod. Posting Group" := GLAccount."Gen. Bus. Posting Group";
                            "VAT Prod. Posting Group" := GLAccount."VAT Bus. Posting Group";
                        end;
                end;
            end;
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

            trigger OnValidate();
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01);
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 2;
            MinValue = 0;

            trigger OnValidate();
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01);
            end;
        }
        field(8; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
            Editable = false;

            trigger OnValidate();
            begin
                if (Quantity <> 0) then
                    "Unit Price" := Round("Total Price" / Quantity, 0.01)
                else
                    "Unit Price" := 0;
            end;
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

            trigger OnValidate();
            begin
                case Type of
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            if "Unit of Measure Code" = '' then begin
                                "Unit of Measure Code" := Resource."Base Unit of Measure";
                            end;
                            ResourceUofM.Get("No.", "Unit of Measure Code");
                            "Qty. per Unit of Measure" := ResourceUofM."Qty. per Unit of Measure";
                            "Total Price" := Round(Resource."Unit Price" * "Qty. per Unit of Measure");
                        end;
                    Type::"G/L Account":
                        begin
                            "Qty. per Unit of Measure" := 1;
                        end;
                end;
                if CurrFieldNo = FieldNO("Unit of Measure Code") then begin
                    Validate("Unit Price");
                end;
            end;
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

    trigger OnDelete();
    begin
        TestField(Registered, false);
    end;

    trigger OnInsert();
    begin
        SeminarRegistrationHeader.Get("Document No.");
    end;

    var
        GLAccount: Record "G/L Account";
        Resource: Record Resource;
        ResourceUofM: Record "Resource Unit of Measure";
        SeminarRegistrationHeader: Record "CSD Seminar Reg. Header";
}

