# frozen_string_literal: true

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
        def search_user(options = {})
          return [] if options.size <= 0 # Raise error if the size is  <= 0

          users = []
          options.each do |k, v|
            users = Zen::Search::Services::Users.send(:"find_by_#{k}",@user_index, v)
          end

          Zen::Search::Services::Print.objects(users)
        end

        #
        ## Tickets
        #
        def search_ticket(options = {})
          return [] if options.size <= 0 # Raise error if the size is  <= 0

          tickets = []
          options.each do |k, v|
            tickets = Zen::Search::Services::Tickets.send(:"find_by_#{k}",@ticket_index, v)
          end

          Zen::Search::Services::Print.objects(tickets)
        end
      end
    end
  end
end
