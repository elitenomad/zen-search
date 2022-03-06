# frozen_string_literal: true

module Zen
  module Search
    module Generate
      class Indexer
        def initialize(users, tickets)
          @users = users
          @tickets = tickets
        end

        def index!
          u_index = user_index!
          t_index = ticket_index!

          [u_index, t_index]
        end

        private

        def user_index!
          index = Zen::Search::Generate::UserIndexer.new(@users)
          index&.index!

          index
        end

        def ticket_index!
          index = Zen::Search::Generate::TicketIndexer.new(@tickets)
          index&.index!

          index
        end
      end
    end
  end
end
