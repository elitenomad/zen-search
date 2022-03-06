# frozen_string_literal: true

module Zen
  module Search
    module Services
      class Tickets
        # == Zen::Search::Ticket
        # id, type, subject, assignee_id, created_at, tags

        def self.find_by_id(ticket_index, id)
          ticket = ticket_index.id_index[id]
          return [] if ticket.nil?
          
          return [ticket]
        end

        def self.find_by_assignee_id(ticket_index, assignee_id)
          ticket_index.assignee_index[assignee_id] || []
        end

        def self.find_by_type(ticket_index, type)
          ticket_index.type_index[type] || []
        end

        def self.find_after_date(ticket_index, date)
          tickets = ticket_index.id_index.values.flatten
          tickets.select { |ticket| ticket.created_at >= date }
        end

        def self.find_by_subject(ticket_index, subject)
          ticket_index.subject_index[subject.downcase] || []
        end

        def self.find_by_tag(ticket_index, tag)
          ticket_index.tag_index[tag.downcase] || []
        end
      end
    end
  end
end
