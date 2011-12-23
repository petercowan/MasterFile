require 'rubygems'
gem 'activerecord'

#Spreadsheet Column names
#
#E. I. N.
#Name
#In Care of Name
#Address
#City
#State
#Zip Code
#Group Exemption Number
#Subsection Code
#Affiliation Code
#Classification Code
#Ruling Date
#Deductibility Code
#Foundation Code
#Activity Code
#Organization Code
#Exempt Organization Status Code
#Advanced Ruling Expiration Date
#Tax Period
#Asset Code
#Income Code
#Filing Requirement Code
#Blank
#Accounting Period
#Asset Amount
#Income Amount
#Negative Sign
#Form 990 Revenue Amount
#Negative Sign
#NTEE Code
#Sort or Secondary Name

module MasterFile
    class Organization
        EIN = 'E. I. N.'
        NAME = 'Name'
        CARE_OF = 'In Care of Name'
        ADDRESS = 'Address'
        CITY = 'City'
        STATE = 'State'
        ZIP = 'Zip Code'
        GROUP = 'Group Exemption Number'
        SUBSECTION_CODE = 'Subsection Code'
        AFFILIATION_CODE = 'Affiliation Code'
        CLASSIFICATION_CODE = 'Classification Code'
        RULING_DATE_CODE = 'Ruling Date'
        DEDUCTIBILITY_CODE = 'Deductibility Code'
        FOUNDATION_CODE = 'Foundation Code'
        ACTIVITY_CODE = 'Activity Code'
        ORGANIZATION_CODE = 'Organization Code'
        STATUS_CODE = 'Exempt Organization Status Code'
        ADVANCED_RULING_DATE_CODE = 'Advanced Ruling Expiration Date'
        TAX_CODE = 'Tax Period'
        ASSET_CODE = 'Asset Code'
        INCOME_CODE = 'Income Code'
        FILING_CODE = 'Filing Requirement Code'
        ACCOUNTING = 'Accounting Period'
        ASSETS = 'Asset Amount'
        INCOME = 'Income Amount'
        REVENUE = 'Form 990 Revenue Amount'
        NTEE = 'NTEE Code'

        attr_reader ein, name, care_of, address, city, state, zip_code, assetts, income, revenue, ntee_codes

        @labels
        @row

        def initialize(labels, row)
            update labels, row
        end

        def update(labels, row)
            @labels = labels
            @row = row

            set_values
        end

        private

        def set_values
            @ein = get_value EIN
            @name = get_value NAME
            @care_of = get_value CARE_OF
            @address = get_value ADDRESS
            @city = get_value CITY
            @state = get_value STATE
            @zip_code = get_value ZIP
            @assetts = get_value ASSETS
            @income = get_value INCOME
            @revenue = get_value REVENUE
            @ntee_codes = get_value NTEE
        end

        def get_value(column_name)
            @row[@labels[column_name]]
        end

        def get_values(column_name)
            @row[@labels[column_name]].split ','
        end
    end
end
