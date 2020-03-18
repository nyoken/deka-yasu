class ApplicationController < ActionController::Base
  def parse_json(url)
    url = URI.encode(url) #エスケープ
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    @result = JSON.parse(json)
  end
end
