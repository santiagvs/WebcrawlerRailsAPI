require 'open-uri'

module Scraper
    class ListService
        QUOTE_URL = 'http://quotes.toscrape.com/page/1/'
        
        def initialize(tag)
            @tag = tag
        end
        
        def run
            quotes = []
            
            if available_time?
                return @quote.page.as_json
            end

            doc = Nokogiri::HTML(URI.open(QUOTE_URL))

            all_quotes = doc.css('div.quote')
            all_quotes.each do |quo|
                quotes.push({ 
                    quote: quo.css('span.text').text.tr('“”', ''),
                    author: quo.css('small.author').text,
                    author_about: "http://quotes.toscrape.com" + quo.css('a')[0].attributes['href'].value,
                    tags: quo.css('div.tags').css('a.tag').map { |t| t.text }
                }) unless quo.css('div.tags').css('a.tag').map { |t| t.text }.all? { |t| t != @tag }
                
            end

            persist(quotes)

            quotes.to_json
        end

        private

        def persist(quotes)
            Quote.create(tag: @tag, timestamp: Time.zone.now, page: quotes.to_json)
        end
       
        def available_time?
            @quote = Quote.find_by(tag: @tag) rescue nil

            return unless @quote
            
            @quote.timestamp < 2.minutes.from_now
        end
    end
end
