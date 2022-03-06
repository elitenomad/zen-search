module ZenSearchTestHelper
    class Mock
      def users
        [
            {
              "_id": 1,
              "name": "Francisca Rasmussen",
              "created_at": "2016-04-15T05:19:46-10:00",
              "verified": true
            },
            {
              "_id": 2,
              "name": "Cross Barlow",
              "created_at": "2016-06-23T10:31:39-10:00",
              "verified": true
            },
            {
              "_id": 3,
              "name": "Ingrid Wagner",
              "created_at": "2016-07-28T05:29:25-10:00",
              "verified": false
            }
        ]
      end
  
      def tickets
        [
            {
              "_id": "436bf9b0-1147-4c0a-8439-6f79833bff5b",
              "created_at": "2016-04-28T11:19:34-10:00",
              "type": "incident",
              "subject": "A Catastrophe in Korea (North)",
              "assignee_id": 1,
              "tags": [
                "Ohio",
                "Pennsylvania",
                "American Samoa",
                "Northern Mariana Islands"
              ]
            },
            {
              "_id": "1a227508-9f39-427c-8f57-1b72f3fab87c",
              "created_at": "2016-04-14T08:32:31-10:00",
              "type": "incident",
              "subject": "A Catastrophe in Micronesia",
              "assignee_id": 2,
              "tags": [
                "Puerto Rico",
                "Idaho",
                "Oklahoma",
                "Louisiana"
              ]
            },
            {
              "_id": "2217c7dc-7371-4401-8738-0a8a8aedc08d",
              "created_at": "2016-07-16T12:05:12-10:00",
              "type": "problem",
              "subject": "A Catastrophe in Hungary",
              "assignee_id": 3,
              "tags": [
                "Massachusetts",
                "New York",
                "Minnesota",
                "New Jersey"
              ]
            }
        ]
      end

      def indexes
        # Load mock users and tickets
        @user_collection ||= Zen::Search::Loader.run(users, 'Users')
        @ticket_collection ||= Zen::Search::Loader.run(tickets, 'Tickets')
        
        # Update mock collections for relationships
        Zen::Search::Updater.run(@user_collection, @ticket_collection)
        
        # Create indexes for mock data
        indexer = Zen::Search::Generate::Indexer.new(@user_collection, @ticket_collection)

        # Return mock indexes
        indexer.index!
      end
    end
  end