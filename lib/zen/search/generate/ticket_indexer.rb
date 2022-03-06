# frozen_string_literal: true

module Zen
  module Search
    module Generate
      class TicketIndexer
        attr_reader :id_index, :type_index, :subject_index, :assignee_index, :tag_index

        def initialize(tickets)
          @tickets = tickets

          # Indexes
          @id_index ||= {}
          @type_index ||= {}
          @subject_index ||= {}
          @assignee_index ||= {}
          @tag_index ||= {}
        end

        def for_id!
          @tickets.each do |ticket|
            @id_index[ticket.id] = ticket
          end
        end

        def for_type!
          @type_index = @tickets.group_by(&:type)
        end

        def for_subject!
          @tickets.each do |ticket|
            Zen::Search::Helpers.text_index(ticket, ticket&.subject, @subject_index)
            Zen::Search::Helpers.tokenized_index(ticket, ticket&.subject, @subject_index)
          end
        end

        def for_assignee!
          @assignee_index = @tickets.group_by(&:assignee_id)
        end

        def for_tags!
          @tickets.each do |ticket|
            ticket.tags.each do |tag|
              Zen::Search::Helpers.text_index(ticket, tag, @tag_index)
              Zen::Search::Helpers.tokenized_index(ticket, tag, @tag_index)
            end
          end
        end

        def index!
          for_id!
          for_type!
          for_subject!
          for_assignee!
          for_tags!
        end
      end
    end
  end
end
