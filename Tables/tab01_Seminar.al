table 50101 "CSD Seminar"
//Lab 5.2 Task 2 
{
    Caption = 'Seminar';
    DataClassification = ToBeClassified;
    LookupPageId = "CSD Seminar List";
    DrillDownPageId = "CSD Seminar List";

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetUp.Get;
                    NoSeriesMgt.TestManual(seminarSetup."Seminar Nos.");
                    "No.Series" := '';
                end;

            end;


        }
        field(20; "Name"; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or
                ("Search Name" = '') then
                    "Search Name" := Name;

            end;
        }
        field(30; "Seminar Duration"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 1;
        }
        field(40; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = ToBeClassified;
        }
        field(50; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = ToBeClassified;
        }
        field(60; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
            DataClassification = ToBeClassified;
        }
        field(70; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(80; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = ToBeClassified;

        }
        field(90; "Comment"; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("CSD Seminar Comment Line"
            where("Table Name" = const("Seminar"),
               "No." = field("No.")));
        }
        field(100; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
            DataClassification = ToBeClassified;
        }
        field(110; "Gen.Prod.Posting Group"; Code[10])
        {
            Caption = 'Gen.Prod.Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (xRec."Gen.Prod.Posting Group" <>
                "Gen.Prod.Posting Group") then begin
                    if GenProdPostingGroup.ValidateVatProdPostingGroup
                    (GenProdPostingGroup, "Gen.Prod.Posting Group") then
                        Validate("VAT Prod. Posting Group",
                        GenProdPostingGroup."Def. VAT Prod. Posting Group");
                end;


            end;
        }
        field(120; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = ToBeClassified;
        }
        field(130; "No.Series"; Code[10])
        {
            Caption = 'No.Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "Search Name")
        {

        }
    }


    var
        SeminarSetup: Record "CSD Seminar Setup";
        CommentLine: Record "CSD Seminar Comment Line";
        Seminar: Record "CSD Seminar";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No.Series", 0D, "No.", "No.Series");
        end;

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;


    trigger OnRename()
    begin

        "Last Date Modified" := Today;

    end;

    trigger OnDelete()
    begin

        CommentLine.Reset;
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.SetRange("No.", Rec."No.");
        CommentLine.DeleteAll;
    end;


    procedure AssistEdit(): Boolean;
    begin
        Seminar := Rec;
        SeminarSetup.get;
        SeminarSetup.TestField("Seminar Nos.");
        if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.", xRec."No.Series", Seminar."No.Series") then begin
            NoSeriesMgt.SetSeries(Seminar."No.");
            Rec := Seminar;
            exit(true);
        end;
    end;






}








