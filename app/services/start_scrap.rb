require 'nokogiri'
require 'open-uri'

class StartScrap
  def initialize
    @page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
    Crypto.destroy_all
  end

  def perform
    def get_stock
      info = []
      n = 0
      currencies = []
      values = []
      @page.css(".currency-name-container").each do |currency|
        currencies << currency.text
      end

      @page.css(".price").each do |value|
        values << value.text
      end

      while n < 50 #@page.css(".price").length
        info[n] = {:currency => currencies[n], :value => values[n]}
        n +=1
      end
      return info
    end

    save(get_stock)

  end

  def save(arr)
    h = {}
    arr.each do |cur|
      Crypto.create(name: cur[:currency], value: cur[:value])
      h[cur[:currency]] = cur[:value]
    end
    return h
  end
end
