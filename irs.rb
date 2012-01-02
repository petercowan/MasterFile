require 'rubygems'
require 'sqlite3'
require 'active_record'
require File.join(File.dirname(__FILE__), *%w[xls_charity_parser])
require File.join(File.dirname(__FILE__), *%w[data_downloader])
require File.join(File.dirname(__FILE__), *%w[org])

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
    orgs = xls.parse_file

    orgs.each do |org_hash|
        IRS::Org.transaction do
            ein = org_hash[:ein]
            if (org = IRS::Org.find_by_ein(ein))
                if org.changed?
                    #org.save
                end
            else
                org = IRS::Org.new org_hash
                #org.save
            end
        end
    end
end unless files.nil?

puts "hi"