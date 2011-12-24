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

        def initialize(labels, row)
            set_values self, labels, row
            created_at = Time.now
        end

        def updated?(labels, row)
            (name != get_value(NAME, labels, row) \
            || care_of != get_value(CARE_OF, labels, row) \
            || address != get_value(ADDRESS, labels, row) \
            || city != get_value(CITY, labels, row) \
            || state != get_value(STATE, labels, row) \
            || zip_code != get_value(ZIP, labels, row) \
            || assetts != get_value(ASSETS, labels, row) \
            || income != get_value(INCOME, labels, row) \
            || revenue != get_value(REVENUE, labels, row))
        end

        def update(labels, row)
            set_values self, labels, row
            updated_at = Time.now
        end

        private

        def self.set_values(org, labels, row)
            org.ein = get_value EIN, labels, row
            org.name = get_value NAME, labels, row
            org.care_of = get_value CARE_OF, labels, row
            org.address = get_value ADDRESS, labels, row
            org.city = get_value CITY, labels, row
            org.state = get_value STATE, labels, row
            org.zip_code = get_value ZIP, labels, row
            org.assetts = get_value ASSETS, labels, row
            org.income = get_value INCOME, labels, row
            org.revenue = get_value REVENUE, labels, row
            #@ntee_codes = get_values NTEE
        end

        def self.get_value(column_name, labels, row)
            row[labels[column_name]]
        end

        def self.get_values(column_name, labels, row)
            row[labels[column_name]].split ','
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
