require 'rubygems'
gem 'roo'

module MasterFile
    class XLSParser
        @xls #Excel file to parse

        def initialize(file_path)
            @xls = Excel.new(file_path)
            @xls.default_sheet = oo.sheets.first

        end

        def parse_file()
            header_row = @xls.first_row
            last_row = @xls.last_row

            labels = to_hash_keys first_row { |item| header_row.index(item)}
            rows = []
            header_row + 1.upto(last_row) do |index|
                row = @xls.row(index)
                rows << row
            end

            return labels, rows
        end

        private

        def to_hash_keys(array, &block)
            Hash[*array.collect { |v|
                [v, block.call(v)]
            }.flatten]
        end
    end
end
