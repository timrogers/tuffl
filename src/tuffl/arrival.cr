require "json"

module Tuffl
  class Arrival
    DUE  = "Due"
    MIN  = "min"
    MINS = "mins"

    JSON.mapping(
      station_name: {key: "stationName", type: String},
      line_name: {key: "lineName", type: String},
      platform_name: {key: "platformName", type: String},
      destination_name: {key: "destinationName", type: String},
      towards: String,
      due_in_seconds: {key: "timeToStation", type: Int32},
      current_location: {key: "currentLocation", type: String}
    )

    def destination_name
      @destination_name.gsub("Underground Station", "").strip
    end

    def due_in_minutes : Int32
      (due_in_seconds / 60).round(0)
    end

    def due : String
      return DUE if due_in_minutes == 0

      if due_in_minutes == 1
        "#{due_in_minutes} #{MIN}"
      else
        "#{due_in_minutes} #{MINS}"
      end
    end
  end
end
