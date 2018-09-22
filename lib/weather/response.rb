# -*- coding: utf-8 -*-
require 'nokogiri'

class XMLResponse
  def initialize(raw_response)
    @response = Nokogiri::XML(raw_response)
  end
end

class IndexXMLResponse < XMLResponse
  def city_url(city)
    @response.at("data:contains('#{city}')").css("url").text
  end
end

class CityXMLResponse < XMLResponse

  def today_max
    search_metric("Temperatura Máxima").first
  end

  def today_min
    search_metric("Temperatura Mínima").first
  end

  def max
    avg(search_metric("Temperatura Máxima"))
  end

  def min
    avg(search_metric("Temperatura Mínima"))
  end

  private

  def search_metric(metric)
    @response
      .css("var:contains('#{metric}')")
      .css("data")
      .css("forecast")
      .collect(&:values)
      .map(&:last)
      .map(&:to_f)
  end

  def avg(list) list.reduce(:+) / list.size end
end
