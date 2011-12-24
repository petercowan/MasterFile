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

            local_files = []
            begin
                local_files << links.each { |link| download_file link }
            rescue
                #do something here?
            end
            local_files
        end

        private

        def download_file(rel_path)
            filename = rel_path[rel_path.rindex('/'),rel_path.length - 1]
            local_file = DATA_DIR + filename

            Net::HTTP.start(ROOT_URL) { |http|
                resp = http.get(rel_path)
                open(local_file, "wb") { |file|
                    file.write(resp.body)
                }
            }
            local_file
        end

        def get_abs_links(links)
            links.collect { |link| URI.parse(ROOT_URL).merge(link).to_s }
        end
    end
end