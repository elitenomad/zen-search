# frozen_string_literal: true

require "json"

module Zen
  module Search
    class Loader
      def self.run(data, type = nil)
        case type
        when "Users"
          Zen::Search::Users.new(data)
        when "Tickets"
          Zen::Search::Tickets.new(data)
        end
      end
    end
  end
end
