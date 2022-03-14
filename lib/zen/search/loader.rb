# frozen_string_literal: true

require "json"

module Zen
  module Search
    class Loader
      def self.run(data, type = nil)
        case type
        when "Users"
          Zen::Search::Resources::Users.new(data)
        when "Tickets"
          Zen::Search::Resources::Tickets.new(data)
        end
      end
    end
  end
end
