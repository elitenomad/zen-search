module Zen
    module Search
        module Generate
            class Indexer
                def initialize(users, tickets)
                    @users = users
                    @tickets = tickets
                end

                def index!
                    uIndex = user_index!
                    tIndex = ticket_index!

                    [uIndex, tIndex]
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