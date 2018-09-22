# -*- coding: utf-8 -*-
require 'faraday'

class XMLRequest
  def initialize(endpoint)
    @endpoint = endpoint
  end

  def get
    Faraday.get("#{@endpoint}&affiliate_id=zdo2c683olan").body
  end
end
