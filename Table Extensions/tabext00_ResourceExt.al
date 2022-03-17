tableextension 50100 "CSD ResourceExt" extends Resource
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 Lab 1.1
{
    fields
    {
        modify("Profit %")

        {
            trigger OnAfterValidate()


            begin
                Rec.TestField("Unit Cost");

            end;

        }


        field(50101; "CSD Resource Type"; Enum "CSD Resource Type")

        {
            Caption = 'Resource Type';
            DataClassification = ToBeClassified;

        }
        field(50102; "CSD Maximum Participants"; Integer)

        {

            Caption = 'Maximum Participants';
            DataClassification = ToBeClassified;

        }

        field(50103; "CSD Quantity Per Day"; Decimal)

        {
            Caption = 'Quantity Per Day';
            DataClassification = ToBeClassified;

        }

    }


}