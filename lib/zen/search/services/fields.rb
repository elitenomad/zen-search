module Zen
    module Search
        module Services
            class Fields
                def self.list(type)
                    Zen::Search::Services::Print.list(Zen::Search::Services::Constants::USER_ATTRIBUTES) if type == 'Users'
                    Zen::Search::Services::Print.list(Zen::Search::Services::Constants::TICKET_ATTRIBUTES) if type == 'Tickets'
                end
            end
        end
    end
end