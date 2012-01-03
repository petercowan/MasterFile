require 'rubygems'
require 'roo'

module IRS
    class XLSParser
        @xls #Excel file to parse

        def initialize(file_path)
            super()
            @xls = Excel.new(file_path)
            @xls.default_sheet = @xls.sheets.first
        end

        def parse_file()
            header_row = @xls.row(@xls.first_row)
            labels = Hash[header_row.map { |item| [item, header_row.index(item)] }.flatten]

            orgs = Array.new
            @xls.first_row + 1.upto(@xls.last_row) do |index|
                row = @xls.row(index)
                org = Hash.new
                labels.keys.each { |key|
                    if (attr_name = IRS::Org.get_attribute_name(key))
                        org[attr_name] = row[labels[key]]
                    end
                }
                orgs << org
            end
            orgs
        end
    end
end
