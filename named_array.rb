module IRS
    class NamedArray < Array
        @labels
        @row

        def initialize(labels, row)
            @labels = labels
            @row = row
        end

        def get_value(column_name)
            @row[@labels[column_name]]
        end

        def get_values(column_name, sep = ',')
            @row[@labels[column_name]].split sep
        end
    end
end