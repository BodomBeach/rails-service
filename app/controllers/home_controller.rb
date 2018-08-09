class HomeController < ApplicationController
  def index
    @scrap = StartScrap.new
    @currencies = @scrap.perform
    @arr = []
    i = 0
    while i < @currencies.keys.length do
      @arr << [@currencies.keys[i], @currencies.keys[i]]
      i += 1
    end
    if @currencies[params[:currency]]
      @name = params[:currency]
      @value = @currencies[params[:currency]]
    end
  end
end
