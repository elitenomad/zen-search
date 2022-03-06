# frozen_string_literal: true

require "json"

# Updating the collection objects to achieve 2 relationships
#   - User has many tickets
#   - Ticket belongs to a User

module Zen
  module Search
    class Updater
      def self.run(users, tickets)
        users.each do |user|
          # List all the ticket for a user
          user.tickets = tickets.select do |ticket|
            ticket.assignee_id == user.id
          end

          # Update the values with first 8 Uniq chars
          user.tickets = user.tickets.map { |ticket| ticket.id[0, 8] }
        end

        tickets.each do |ticket|
          ticket.assignee_name = users.find { |user| user.id == ticket.assignee_id }&.name
        end

        [users, tickets]
      end
    end
  end
end
