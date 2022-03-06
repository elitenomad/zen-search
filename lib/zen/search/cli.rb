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
            if file =~ /users/ 
                @user_collection = Zen::Search::Loader.run(data, 'Users')
            elsif file =~  /tickets/
                @ticket_collection = Zen::Search::Loader.run(data, 'Tickets')
            else
                raise Zen::Search::FileFormatNotSupportedError.new("Only Users and Tickets can be parsed.")
            end
          end
        end
  
        def run(files, instructions = [])
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

                if input == "Search Zendesk"
                  search_zendesk
                elsif input == "View Searchable Fields"
                  view_searchable_fields
                end
              end
            rescue StandardError => e
              raise Zen::Search::StandardError.new("Something went wrong!!!")
            end
        end

        def view_searchable_fields
          input = prompt.select(
            "List Searchable Fields for", 
            ["Users", "Tickets"]
          )
    
          @service.display_fields_for(input)
        end

        def search_zendesk
          input = prompt.select(
            "Select", 
            ["Users", "Tickets"]
          )

          fields = Zen::Search::Helpers.fields_for(input)
          field = prompt.select(
            "List Searchable Fields for #{input}", 
            fields
          )

          if input == 'Users'
            if field == '_id'
              id = prompt.ask("Enter search value", default: "", convert: :int)
              @service.display_user_by_id(id)
            elsif field == 'name'
              name = prompt.ask("Enter search value", default: "")
              @service.display_user_by_name(name)
            elsif field == 'created_at'
              date = prompt.ask("Enter search value", default: Date.today, convert: :date)
              @service.display_users_from_date(date)
            elsif field == 'verified'
              id = prompt.ask("Enter search value", default: "", convert: :bool)
              @service.display_verified_users(id)
            end
          end

          if input == 'Tickets'
            if field == '_id'
              id = prompt.ask("Enter search value", default: "")
              @service.display_ticket_by_id(id)
            elsif field == 'type'
              type = prompt.ask("Enter search value", default: "")
              @service.display_tickets_by_type(type)
            elsif field == 'created_at'
              date = prompt.ask("Enter search value", default: Date.today, convert: :date)
              @service.display_tickets_from_date(date)
            elsif field == 'subject'
              subject = prompt.ask("Enter search value", default: "")
              @service.display_tickets_by_subject(subject)
            elsif field == 'assignee_id'
              assignee_id = prompt.ask("Enter search value", default: "",  convert: :int)
              @service.display_tickets_by_assignee_id(assignee_id)
            elsif field == 'tags'
              tag = prompt.ask("Enter search value", default: "")
              @service.display_tickets_by_tag(tag)
            end
          end
        end
      end
    end
  end