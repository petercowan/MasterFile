require 'rubygems'
require 'uri'
require 'mechanize'
require 'nokogiri'

module IRS
    class DataDownloader
        ROOT_URL = "http://www.irs.gov"
        DOWNLOAD_URL = "http://www.irs.gov/taxstats/charitablestats/article/0,,id=97186,00.html"
        DATA_DIR = 'data/xls/'

        def download_files
            doc = Nokogiri::HTML(open(DOWNLOAD_URL))

            all_links = doc.search('a').find { |a|
                !a['href'].nil? && a['href'].match(/\/pub\/irs-soi\/eo[^.]*\.xls/)}.each { |link| puts link.to_s}
            links = doc.search('a').find { |a|
                !a['href'].nil? && a['href'].match(/\/pub\/irs-soi\/eo_[^.]*\.xls/)
            }.collect {|a| a[1]}

            local_files = Array.new
            if (!links.nil?)
                puts "Downloading " + links.length.to_s + "files"
                links.each do |link|
                    puts "Downloading file " + link.to_s
                    local_files << download_file(link)
                end
            end
            local_files
        end

        private

        def download_file(rel_path)
            local_file = DATA_DIR + File.basename(rel_path)


            #Mechanize
            agent = Mechanize.new
            agent.get(ROOT_URL + rel_path).save_as(local_file)
            puts "local_file " + local_file
            local_file
        end
    end
end