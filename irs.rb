require 'data_downloader.rb'

downloader = MasterFile::DataDownloader.new
files = downloader.download_files

file.each do |file|
    xls = MasterFile::XLSParser.new file
    lables, rows = xls.parse

    rows.each do |row|
        charity = new MasterFile::Organization(labels, row)
        #save charity
    end
end