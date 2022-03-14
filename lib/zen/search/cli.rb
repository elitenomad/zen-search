# frozen_string_literal: true

require "tty-prompt"

module Zen
  module Search
    class CLI
      attr_reader :prompt

      def initialize
        @prompt = TTY::Prompt.new

        @user_collection = []
        @ticket_collection = []
      end

      def load(files)
        files.each do |file|
          data = Zen::Search::Parse.run(file)

          # For now depending on hardcoded filenames
          case file
          when /users/
            @user_collection = Zen::Search::Loader.run(data, "Users")
          when /tickets/
            @ticket_collection = Zen::Search::Loader.run(data, "Tickets")
          else
            raise Zen::Search::FileFormatNotSupportedError, "Only Users and Tickets can be parsed."
          end
        end
      end

      def run(files)
        # setup and load collections
        load(files)

        # setup relationship and update collections
        Zen::Search::Updater.run(@user_collection, @ticket_collection)

        # setup indexes (user, ticket)
        indexer = Zen::Search::Generate::Indexer.new(@user_collection, @ticket_collection)
        uIndex, tIndex = indexer.index!
        
        # Make indexes available to Main service class (Acts like a controller)
        @service = Zen::Search::Services::Core.new(uIndex, tIndex)

        begin
          loop do
            input = prompt.select(
              "Select search options:",
              ["Search Zendesk", "View Searchable Fields", "quit"]
            )

            break if input =~ /quit/

            case input
            when "Search Zendesk"
              search_zendesk
            when "View Searchable Fields"
              view_searchable_fields
            end
          end
        rescue StandardError => e
          raise Zen::Search::StandardError, "Something went wrong!!!"
        end
      end

      def view_searchable_fields
        input = prompt.select(
          "List Searchable Fields for",
          %w[Users Tickets]
        )

        @service.display_fields_for(input)
      end

      def search_zendesk
        input = prompt.select(
          "Select",
          %w[Users Tickets]
        )

        fields = Zen::Search::Helpers.fields_for(input)
        field = prompt.select(
          "List Searchable Fields for #{input}",
          fields
        )

        if input == "Users"
          case field
          when "_id"
            id = prompt.ask("Enter search value", default: "") do |q|
              q.required true
              q.validate(/\A\d+\Z/, "Invalid ID")
            end

            @service.search_user({id: id.to_i})
          when "name"
            name = prompt.ask("Enter search value") do |q|
              q.required true
            end

            @service.search_user({name: name})
          when "created_at"
            date = prompt.ask("Enter search value", default: Date.today, convert: :date)
            @service.search_user({created_at: date})
          when "verified"
            verified = prompt.enum_select("Enter search value", choices = %w[true false nil], convert: :sym)
            @service.search_user({verified: verified})
          end
        end

        if input == "Tickets"
          case field
          when "_id"
            id = prompt.ask("Enter search value") do |q|
              q.required true
            end

            @service.search_ticket({id: id})
          when "type"
            type = prompt.enum_select("Enter search value", choices = %w[incident problem question task nil])
            @service.search({type: Zen::Search::Helpers.nillify_string(type)})
          when "created_at"
            date = prompt.ask("Enter search value", default: Date.today, convert: :date)
            @service.search_ticket({created_at: date})
          when "subject"
            id = prompt.ask("Enter search value")
            @service.search_ticket({subject: id})
          when "assignee_id"
            assignee_id = prompt.ask("Enter search value", default: nil, convert: :int)
            @service.search_ticket({assignee_id: assignee_id})
          when "tags"
            tag = prompt.ask("Enter search value", default: "")
            @service.search_ticket({tag: tag})
          end
        end
      end
    end
  end
end
