require 'json'

module Zen
    module Search
      class Updater
        def self.run(users, tickets)
            # Updating the collection objects to achieve 2 relationships
            #   - User has many tickets
            #   - Ticket belongs to a User
            users.each do |user|
                user.tickets = tickets.select{|ticket| ticket.assignee_id == user.id }.map(&:id)
            end

            tickets.each do |ticket|
                ticket.assignee_name = users.find{|user| user.id == ticket.assignee_id }&.name
            end

            [users, tickets]
        end
      end
    end
  end