page 50134 "CSD Posted Seminar Reg."
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 3
    //     - Created new page

    Caption = 'Posted Seminar Registration';
    Editable = false;
    PageType = Document;
    SourceTable = "CSD Posted Seminar Reg. Header";


    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                }
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ApplicationArea = All;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                }
            }
            part(SeminarRegistrationLines; 50135)
            {
                SubPageLink = "Document No." = Field("No.");
                ApplicationArea = all;
            }
            group("Seminar Room")
            {
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = all;
                }
                field("Room Name"; Rec."Room Name")
                {
                    ApplicationArea = all;
                }
                field("Room Address"; Rec."Room Address")
                {
                    ApplicationArea = all;
                }
                field("Room Address 2"; Rec."Room Address 2")
                {
                    ApplicationArea = all;
                }
                field("Room Post Code"; Rec."Room Post Code")
                {
                    ApplicationArea = all;
                }
                field("Room City"; Rec."Room City")
                {
                    ApplicationArea = all;
                }
                field("Room Country/Reg. Code"; Rec."Room Country/Reg. Code")
                {
                    ApplicationArea = all;
                }
                field("Room County"; Rec."Room County")
                {
                    ApplicationArea = all;
                }
            }
            group(Invoicing)
            {
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part("CSD Seminar Details FactBox"; 50117)
            {
                SubPageLink = "No." = Field("Seminar No.");
                ApplicationArea = all;
            }
            part("Coustmer Details FactBox"; 9084)
            {
                Provider = SeminarRegistrationLines;
                SubPageLink = "No." = Field("Bill-to Customer No.");
                ApplicationArea = all;
            }
            systempart("Links"; Links)
            {
                ApplicationArea = all;
            }
            systempart("Notes"; Notes)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Seminar Registration")
            {
                Caption = '&Seminar Registration';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page 50106;
                    RunPageLink = "No." = Field("No.");
                    RunPageView = where("Table Name" = const(" Posted Seminar Reg.Header"));
                }
                action("&Charges")
                {
                    Caption = '&Charges';
                    Image = Costs;
                    RunObject = Page 50139;
                    RunPageLink = "Document No." = Field("No.");
                }
            }
        }
    }
}

