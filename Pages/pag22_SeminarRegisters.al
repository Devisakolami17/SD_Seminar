page 50122 "CSD Seminar Registers "
{
    //Chap 7 Lab 2=11
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Seminar Register";
    Caption = 'Seminar Registers';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;

                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {
            systempart("Record Links"; Links)
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
        area(Navigation)
        {
            action("Seminar Ledgers")
            {
                ApplicationArea = All;
                Image = WarrantyLedger;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}