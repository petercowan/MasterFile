require 'rubygems'
require 'roo'

module IRS
    class XLSParser
        @xls #Excel file to parse

        def initialize(file_path)
            @xls = Excel.new(file_path)
            @xls.default_sheet = @xls.sheets.first
        end

        def parse_file()
            header_row = @xls.first_row
            last_row = @xls.last_row
            labels = to_hash_keys first_row { |item| header_row.index(item) }

            orgs = Array.new
            header_row + 1.upto(last_row) do |index|
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

        private

        def to_hash_keys(array, &block)
            Hash[*array.collect { |v|
                [v, block.call(v)]
            }.flatten]
        end
    end
end
