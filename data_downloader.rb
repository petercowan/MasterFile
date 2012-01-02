require 'rubygems'
require 'uri'
require 'net/http'
require 'nokogiri'

module IRS
    class DataDownloader
        ROOT_URL = "http://www.irs.gov/"
        DOWNLOAD_URL = "http://www.irs.gov/taxstats/charitablestats/article/0,,id=97186,00.html"
        DATA_DIR = 'data/xls/'

        def download_files
            doc = Nokogiri::HTML.parse(DOWNLOAD_URL)

            links = doc.search('a').find { |link| link['href'].matches(/\/pub\/irs-soi\/eo_[^.]*\.xls/) }

            if (!links.nil?)
                local_files = links.each do |link|
                    begin
                        download_file(link)
                    rescue
                        #todo - log error, code smell
                    end
                end
                local_files
            end
        end

        private

        def download_file(rel_path)
            local_file = DATA_DIR + File.basename(rel_path)

            #Mechanize
            Net::HTTP.start(ROOT_URL) { |http|
                begin
                    resp = http.get(rel_path)
                    open(local_file, "wb") { |file|
                        file.write(resp.body)
                    }
                rescue
                    #todo - log error, code smell
                end
            }
            local_file
        end
    end
end