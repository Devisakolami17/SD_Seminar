table 50118 "CSD Posted Seminar Reg. Header"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 Lab 3-1

    Caption = 'Posted Seminar Reg. Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;


        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;

        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
            DataClassification = ToBeClassified;


        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            DataClassification = ToBeClassified;
            TableRelation = Resource where(Type = const(Instructor));

            trigger OnValidate();
            begin
                CalcFields("Instructor Name"); // nqse do te lexosh dicka perdoret calcfield ne ketete rast oper  flowfield 
            end;
        }
        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
            CalcFormula = Lookup(Resource.Name where("No." = Field("Instructor Resource No."),
                                                      Type = const(Instructor)));

            Editable = false;
            FieldClass = FlowField;

        }
        field(7; "Status"; Enum "Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            //OptionCaption = 'Planning,Registration,Closed,Canceled';
            //OptionMembers = Planning,Registration,Closed,Canceled;
        }
        field(8; Duration; Decimal)
        {
            DecimalPlaces = 0 : 1;
            Caption = 'Duration';
            DataClassification = ToBeClassified;

        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = ToBeClassified;
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = ToBeClassified;
        }
        field(11; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            DataClassification = ToBeClassified;
            TableRelation = Resource where(Type = const(Room));

        }
        field(12; "Room Name"; Text[30])
        {
            Caption = 'Room Name';
            DataClassification = ToBeClassified;
        }
        field(13; "Room Address"; Text[30])
        {
            Caption = 'Room Address';
            DataClassification = ToBeClassified;
        }
        field(14; "Room Address 2"; Text[30])
        {
            Caption = 'Room Address 2';
            DataClassification = ToBeClassified;
        }
        field(15; "Room Post Code"; Code[20])
        {
            Caption = 'Room Post Code';
            TableRelation = "Post Code".Code;
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;


        }
        field(16; "Room City"; Text[30])
        {
            Caption = 'Room City';
            DataClassification = ToBeClassified;


        }
        field(17; "Room Country/Reg. Code"; Code[10])
        {
            Caption = 'Room Country/Reg. Code';
            TableRelation = "Country/Region";
            DataClassification = ToBeClassified;
        }
        field(18; "Room County"; Text[30])
        {
            Caption = 'Room County';
            DataClassification = ToBeClassified;
        }
        field(19; "Seminar Price"; Decimal)
        {
            AutoFormatType = 1; //formaton si amount 
            Caption = 'Seminar Price';
            DataClassification = ToBeClassified;

        }
        field(20; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
            DataClassification = ToBeClassified;
        }
        field(21; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
            DataClassification = ToBeClassified;
        }
        field(22; Comment; Boolean)
        {
            Caption = 'Comment';
            CalcFormula = Exist("CSD Seminar Comment Line" where("Table Name" = const(" Posted Seminar Reg.Header"),
                   "No." = Field("No.")));


            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(24; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;

        }
        field(25; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code".Code;
            DataClassification = ToBeClassified;
        }
        field(26; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series".Code;
        }
        field(27; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;

        }
        field(28; "User Id"; Code[50])
        {
            Caption = 'User Id';
            TableRelation = User;
            ValidateTableRelation = false;
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "source Code";
        }

    }

    keys
    {
        key(PK; "No.")
        {
        }
        key(Key2; "Room Resource No.") // lehtesim kerkimi nuk kane asnjje funksion ne code 
        {
            SumIndexFields = Duration; // ta perpjeshtu procesimin e te dhenave 
        }
    }






}

