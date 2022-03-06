require 'json'

module Zen
    module Search
      class Loader
        def self.run(data, type = nil)
          if type == 'Users'
            return Zen::Search::Users.new(data)
          elsif type == 'Tickets'
            return Zen::Search::Tickets.new(data)
          end
        end
      end
    end
  end