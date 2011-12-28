require 'rubygems'
require 'active_record'

module IRS
    class Org < ActiveRecord::Base
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

#        attr_reader ein, name, care_of, address, city, state, zip_code, assetts, income, revenue

        def initialize(row)
            set_values row
            self.created_at = Time.now
            self.updated_at = created_at
        end

        def updated?(row)
            (self.name != row.get_value(NAME) \
            || self.care_of != row.get_value(CARE_OF) \
            || self.address != row.get_value(ADDRESS) \
            || self.city != row.get_value(CITY) \
            || self.state != row.get_value(STATE) \
            || self.zip_code != row.get_value(ZIP) \
            || self.assetts != row.get_value(ASSETS) \
            || self.income != row.get_value(INCOME) \
            || self.revenue != row.get_value(REVENUE))
        end

        def update(row)
            set_values row
            self.updated_at = Time.now
        end

        private

        def set_values(row)
            self.ein = row.get_value EIN
            self.name = row.get_value NAME
            self.care_of = row.get_value CARE_OF
            self.address = row.get_value ADDRESS
            self.city = row.get_value CITY
            self.state = row.get_value STATE
            self.zip_code = row.get_value ZIP
            self.assetts = row.get_value ASSETS
            self.income = row.get_value INCOME
            self.revenue = row.get_value REVENUE
            #@ntee_codes = row.get_values NTEE
        end
    end
end
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
