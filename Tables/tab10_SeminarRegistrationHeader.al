table 50110 "CSD Seminar Reg. Header"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 6 - Lab 1-3 & Lab 1-4
    //     - Created new table

    Caption = 'Seminar Registration Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate(); //desing patterns gjithm kjo rruge ndiqet 
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.Get;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Registration Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if "Starting Date" <> xRec."Starting Date" then
                    TestField(Status, Status::Planning);
            end;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if "Seminar No." <> xRec."Seminar No." then begin
                    SeminarRegLine.Reset;
                    SeminarRegLine.SetRange("Document No.", "No.");
                    SeminarRegLine.SetRange(Registered, true);
                    if not SeminarRegLine.Isempty then
                        ERROR(
                          Text002,
                          FieldCaption("Seminar No."),
                          SeminarRegLine.TableCaption,
                          SeminarRegLine.FieldCaption(Registered),
                          true);// nk mud te ndryshojme seminar No. nqse Seminar reg true 

                    Seminar.Get("Seminar No.");
                    Seminar.TestField(Blocked, false);
                    Seminar.TestField("Gen.Prod.Posting Group");
                    Seminar.TestField("VAT Prod. Posting Group");
                    "Seminar Name" := Seminar.Name;
                    Duration := Seminar."Seminar Duration";
                    "Seminar Price" := Seminar."Seminar Price";
                    "Gen. Prod. Posting Group" := Seminar."Gen.Prod.Posting Group";
                    "VAT Prod. Posting Group" := Seminar."VAT Prod. Posting Group";
                    "Minimum Participants" := Seminar."Minimum Participants";
                    "Maximum Participants" := Seminar."Maximum Participants";
                end;
            end;
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

            trigger OnValidate();
            begin
                if "Room Resource No." = '' then begin
                    "Room Name" := '';
                    "Room Address" := '';
                    "Room Address 2" := '';
                    "Room Post Code" := '';
                    "Room City" := '';
                    "Room County" := '';
                    "Room Country/Reg. Code" := '';
                end else begin
                    SeminarRoom.GET("Room Resource No.");
                    "Room Name" := SeminarRoom.Name;
                    "Room Address" := SeminarRoom.Address;
                    "Room Address 2" := SeminarRoom."Address 2";
                    "Room Post Code" := SeminarRoom."Post Code";
                    "Room City" := SeminarRoom.City;
                    "Room County" := SeminarRoom.County; //ekziston por nuk eshte visible 
                    "Room Country/Reg. Code" := SeminarRoom."Country/Region Code";

                    if (CurrFieldNo <> 0) then begin //curfield no, validimi i kesaj fushe behet nga nj fushe qe ndodhet ne kete page  validimi i vjen nga jashte 
                        if (SeminarRoom."CSD Maximum Participants" <> 0) and
                           (SeminarRoom."CSD Maximum Participants" < "Maximum Participants")
                        then begin
                            if Confirm(Text004, true,
                                 "Maximum Participants",
                                 SeminarRoom."CSD Maximum Participants",
                                 FieldCaption("Maximum Participants"),
                                 "Maximum Participants",
                                 SeminarRoom."CSD Maximum Participants")
                            then
                                "Maximum Participants" := SeminarRoom."CSD Maximum Participants";
                        end;
                    end;
                end;
            end;
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

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode("Room City", "Room Post Code", "Room County", "Room Country/Reg. Code", (CurrFieldNo <> 0) and GuiAllowed); // design pattern 
            end;
        }
        field(16; "Room City"; Text[30])
        {
            Caption = 'Room City';
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                PostCode.ValidateCity("Room City", "Room Post Code", "Room County", "Room Country/Reg. Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
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

            trigger OnValidate();
            begin
                if ("Seminar Price" <> xRec."Seminar Price") and
                   (Status <> Status::Canceled)
                then begin
                    SeminarRegLine.Reset;
                    SeminarRegLine.SetRange("Document No.", "No.");
                    SeminarRegLine.SetRange(Registered, false);
                    if SeminarRegLine.FindSet(false, false) then // findset gjen 
                        if Confirm(Text005, false,
                             FieldCaption("Seminar Price"),
                             SeminarRegLine.TableCaption)
                        then begin
                            repeat
                                SeminarRegLine.VALIDATE("Seminar Price", "Seminar Price");
                                SeminarRegLine.modify;
                            until SeminarRegLine.NEXT = 0;
                            Rec.modify;
                        end;
                end;
            end;
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
            CalcFormula = Exist("CSD Seminar Comment Line" where("Table Name" = const(" Seminar Registration Header"),
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

            trigger OnLookup(); // ke mundesi te zzgjidhesh 
            begin
                SeminarRegHeader := Rec;
                SeminarSetup.GET;
                SeminarSetup.TestField("Seminar Registration Nos.");
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                if NoSeriesMgt.LookupSeries(SeminarSetup."Posted Seminar Reg. Nos.", SeminarRegHeader."Posting No. Series")
                then begin
                    VALIDATE("Posting No. Series");

                end;
            end;

            trigger OnValidate();
            begin
                if "Posting No. Series" <> '' then begin
                    SeminarSetup.GET;
                    SeminarSetup.TestField("Seminar Registration Nos.");
                    SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                    NoSeriesMgt.TestSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series");
                end;
                TestField("Posting No.", '');
            end;
        }
        field(28; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = ToBeClassified;
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

    var
        PostCode: Record "Post Code";
        Seminar: Record "CSD Seminar";
        SeminarCommentLine: Record "CSD Seminar Comment Line";
        SeminarCharge: Record "CSD Seminar Charge";
        SeminarRegHeader: Record "CSD Seminar Reg. Header";
        SeminarRegLine: Record "CSD Seminar Registration Line";
        SeminarRoom: Record Resource;
        SeminarSetup: Record "CSD Seminar Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: Label 'You cannot delete the Seminar Registration, because there is at least one %1 where %2=%3.';
        Text002: Label 'You cannot change the %1, because there is at least one %2 with %3=%4.'; //fjala e pare qe vjen pas presjes se errotit te emrit 
        Text004: Label 'This Seminar is for %1 participants. \The selected Room has a maximum of %2 participants \Do you want to change %3 for the Seminar from %4 to %5?';
        Text005: Label 'Should the new %1 be copied to all %2 that are not yet invoiced?';
        Text006: Label 'You cannot delete the Seminar Registration, because there is at least one %1.';

    trigger OnDelete();
    begin
        if (CurrFieldNo > 0) then
            TestField(Status, Status::Canceled);
        SeminarRegLine.RESET;
        SeminarRegLine.SETRANGE("Document No.", "No.");
        SeminarRegLine.SETRANGE(Registered, true);
        if SeminarRegLine.FIND('-') then
            ERROR(
              Text001,
              SeminarRegLine.TableCaption,
              SeminarRegLine.FieldCaption(Registered),
              true);
        SeminarRegLine.SETRANGE(Registered);
        SeminarRegLine.deleteALL(true);

        SeminarCharge.RESET;
        SeminarCharge.SETRANGE("Document No.", "No.");
        if not SeminarCharge.ISEMPTY then
            ERROR(Text006, SeminarCharge.TableCaption);

        SeminarCommentLine.RESET;
        SeminarCommentLine.SETRANGE("Table Name", SeminarCommentLine."Table Name"::" Seminar Registration Header");
        SeminarCommentLine.SETRANGE("No.", Rec."No.");
        if SeminarCommentLine.FindSet() then
            repeat
                SeminarCommentLine.Delete();
            until SeminarCommentLine.Next() = 0;
        SeminarCommentLine.deleteALL;
    end;

    trigger OnInsert();
    begin
        if "No." = '' then begin
            SeminarSetup.GET;
            SeminarSetup.TestField("Seminar Registration Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Registration Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitRecord();

    end;

    local procedure InitRecord()
    begin
        if "Posting Date" = 0D then
            "Posting Date" := WORKDATE; // nxjer daten e bc 365 
        "Document Date" := WORKDATE;
        SeminarSetup.GET;
        NoSeriesMgt.SetDefaultSeries("Posting No. Series", SeminarSetup."Posted Seminar Reg. Nos.");
    end;

    procedure AssistEdit(OldSeminarRegHeader: Record "CSD Seminar Reg. Header"): Boolean;
    begin
        SeminarRegHeader := Rec;
        SeminarSetup.GET;
        SeminarSetup.TestField("Seminar Registration Nos.");
        if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Registration Nos.", OldSeminarRegHeader."No. Series", SeminarRegHeader."No. Series") then begin
            SeminarSetup.GET;
            SeminarSetup.TestField("Seminar Registration Nos.");
            NoSeriesMgt.SetSeries(SeminarRegHeader."No.");
            Rec := SeminarRegHeader;
            exit(true);
        end;
    end;
}

