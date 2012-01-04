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

            links = doc.search('a').find_all { |a|
                !a['href'].nil? && a['href'].match(/\/pub\/irs-soi\/eo_[^.]*\.xls/)
            }.collect {|a| a['href']}

            #links.each {|a| puts a.to_s}

            local_files = Array.new
            if (!links.nil?)
                puts "Downloading " + links.length.to_s + " files"
                links.each do |link|
                    local_files << download_file(link.to_s)
                end
            end
            local_files
        end

        private

        def download_file(rel_path)
            local_file = DATA_DIR + File.basename(rel_path)

            if (!File.exists?(local_file))
                puts "Downloading file " + rel_path
                agent = Mechanize.new
                agent.get(ROOT_URL + rel_path).save_as(local_file)
            end
            local_file
        end
    end
end