module Zen
    module Search
        module Services
            class Core
                def initialize(user_index, ticket_index)
                    @user_index = user_index
                    @ticket_index = ticket_index
                end

                #
                ## Fields
                #
                def display_fields_for(type)
                    Zen::Search::Services::Fields.list(type)
                end

                #
                ## Users
                #
                def display_user_by_id(id)
                    users = Zen::Search::Services::Users.find_by_id(@user_index, id)
                    Zen::Search::Services::Print.objects(users)
                end

                def display_user_by_name(name)
                    users = Zen::Search::Services::Users.find_by_name(@user_index, name)
                    Zen::Search::Services::Print.objects(users)
                end

                def display_users_from_date(date)
                    users = Zen::Search::Services::Users.find_after_date(@user_index, date)
                    Zen::Search::Services::Print.objects(users)
                end

                def display_verified_users(verified)
                    users = Zen::Search::Services::Users.find_verified_users(@user_index, verified)
                    Zen::Search::Services::Print.objects(users)
                end

                #
                ## Tickets
                #
                def display_ticket_by_id(id)
                    tickets = Zen::Search::Services::Tickets.find_by_id(@ticket_index, id)
                    Zen::Search::Services::Print.objects(tickets)
                end

                def display_tickets_by_type(type)
                    tickets = Zen::Search::Services::Tickets.find_by_type(@ticket_index, type)
                    Zen::Search::Services::Print.objects(tickets)
                end

                def display_tickets_from_date(date)
                    tickets = Zen::Search::Services::Tickets.find_after_date(@ticket_index, date)
                    Zen::Search::Services::Print.objects(tickets)
                end

                def display_tickets_by_assignee_id(assignee_id)
                    tickets = Zen::Search::Services::Tickets.find_by_assignee_id(@ticket_index, assignee_id)
                    Zen::Search::Services::Print.objects(tickets)
                end

                def display_tickets_by_subject(subject)
                    tickets = Zen::Search::Services::Tickets.find_by_subject(@ticket_index, subject)
                    Zen::Search::Services::Print.objects(tickets)
                end

                def display_tickets_by_tag(tag)
                    tickets = Zen::Search::Services::Tickets.find_by_tag(@ticket_index, tag)
                    Zen::Search::Services::Print.objects(tickets)
                end
            end
        end
    end
end