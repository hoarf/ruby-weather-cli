# -*- coding: utf-8 -*-
require 'nokogiri'
require 'faraday'

class WeatherReporter

  def initialize(options)
    city_endpoint = fetch_city_endpoint(options.endpoint, options.city)
    city_data = fetch_xml(append_affiliate_token(city_endpoint))
    @city_xml_data = build_xml(city_data)
  end

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
  @city_xml_data
    .css("var:contains('#{metric}')")
    .css("data")
    .css("forecast")
    .collect(&:values)
    .map(&:last)
    .map(&:to_f)
end


def fetch_city_endpoint(index_endpoint, city)
  raw_index_data = fetch_xml(index_endpoint)
  index_response = build_xml(raw_index_data)
  index_response.at("data:contains('#{city}')").css("url").text
end

def avg(list) list.reduce(:+) / list.size end
def fetch_xml(endpoint) Faraday.get(endpoint).body end
def build_xml(raw_endpoint_data) Nokogiri::XML(raw_endpoint_data) end
def append_affiliate_token(endpoint) "#{endpoint}&affiliate_id=zdo2c683olan" end

end
