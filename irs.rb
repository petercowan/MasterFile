require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'data_downloader'
require 'xls_charity_parser'
require "org"

MASTERFILE_DB_NAME = '.master_file.db'
MASTERFILE_DB = SQLite3::Database.new('.master_file.db')

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => MASTERFILE_DB_NAME)

#ein, name, care_of, address, city, state, zip_code, assetts, income, revenue, ntee_codes
if !IRS::Org.table_exists?
    ActiveRecord::Base.connection.create_table(:orgs) do |t|
        t.column :ein, :string
        t.column :care_of, :string
        t.column :address, :string
        t.column :city, :string
        t.column :state, :string
        t.column :zip_code, :string
        t.column :address, :float
        t.column :income, :float
        t.column :revenue, :float
        t.column :created_at, :datetime
        t.column :updated_at, :datetime
    end
end

downloader = IRS::DataDownloader.new
files = downloader.download_files

files.each do |file|
    xls = IRS::XLSParser.new file
    rows = xls.parse_file

    rows.each do |row|
        IRS::Org.transaction do
            ein = row.get_value(IRS::Org.EIN)
            org = IRS::Org.find_by_ein(ein)
            if (org == nil)
                org = new IRS::Org(row)
                org.save
            else
                if org.updated?(row)
                    org.update(row)
                    org.save
                end
            end
        end
    end
end