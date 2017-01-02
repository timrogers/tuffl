require "./tuffl/*"
require "terminal_table"
require "cli"

module Tuffl
  class Command < Cli::Command
    HEADINGS = ["Line/Route", "Destination", "Due", "Current Location"]

    version VERSION

    class Help
      header "Fetches the next arrivals for London public transport stops (including the Tube and buses) from the TfL (Transport for London) API."
      footer "(C) 2017 Tim Rogers"
    end

    class Options
      arg "naptan-id", desc: "The NaPTAN (National Public Transport Access Node) identifier for the stop", required: true

      help
      version
    end

    def run
      arrivals = Tuffl::Arrivals.fetch(args.naptan_id)
      puts generate_table(arrivals).render
    end

    private def generate_table(arrivals : Array(Arrival)) : TerminalTable
      table = TerminalTable.new.tap do |t|
        t.headings = HEADINGS

        arrivals.sort_by(&.due_in_seconds).each do |arrival|
          t << present_arrival(arrival)
        end
      end
    end

    private def present_arrival(arrival : Arrival) : Array(String)
      [
        arrival.line_name,
        arrival.destination_name,
        arrival.due,
        arrival.current_location,
      ]
    end
  end
end

Tuffl::Command.run ARGV
