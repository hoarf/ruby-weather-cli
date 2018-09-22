require "test_helper"

class IndexResponseTest < Minitest::Test
  def test_that_it_can_find_valid_city_urls
    request = XMLRequest.new("http://api.tiempo.com/index.php?api_lang=es&division=102")
    response = IndexXMLResponse.new(request.get)

    assert response.city_url('Barcelona') == "http://api.tiempo.com/index.php?api_lang=es&localidad=1200"
  end
end

class CityXMLResponseTest < Minitest::Test

  def test_that_it_can_find_valid_city_urls
    request = XMLRequest.new("http://api.tiempo.com/index.php?api_lang=es&localidad=1200")
    response = CityXMLResponse.new(request.get)

    assert response.max.is_a? Numeric
    assert response.min.is_a? Numeric
    assert response.today_max.is_a? Numeric
    assert response.today_min.is_a? Numeric
  end
end
