require "http/client"
require "json"

module Tuffl
  class Arrivals
    URL_PREFIX = "https://api.tfl.gov.uk/StopPoint/"
    URL_SUFFIX = "/arrivals"

    def self.fetch(naptan_id : String)
      url = self.generate_url(naptan_id)
      response = HTTP::Client.get(url)
      Array(Arrival).from_json(response.body)
    end

    def self.generate_url(naptan_id : String) : String
      "#{URL_PREFIX}#{naptan_id}#{URL_SUFFIX}"
    end
  end
end
