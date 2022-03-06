# frozen_string_literal: true

require "date"

module Zen
  module Search
    class Tickets
      include Enumerable

      def initialize(records)
        @records = records.map do |record|
          Zen::Search::Ticket.new(record.with_indifferent_access)
        end
      end

      def each(&block)
        list.each(&block)
      end

      def schema
        @records.first.attributes
      end

      # Class hierarchy which represents Ticket
      # elements of the Tickets class.
      #
      # == Initialize:
      # id:: Ticket ID
      # type:: Category
      # subject:: Title of the ticket
      # assignee_id:: Ticket Id of the Ticket to which ticket is assigned
      # created_at::  Ticket created at timestamp
      # tags:: Array value to provide relavance to the tickets.
      #
      class Zen::Search::Ticket
        attr_reader :id, :type, :subject, :assignee_id, :created_at, :tags, :options
        attr_accessor :assignee_name

        def initialize(options)
          @id = options[:_id]
          @type = options[:type]
          @subject = options[:subject]
          @assignee_id = options[:assignee_id]
          @assignee_name = nil
          @created_at = DateTime.parse(options[:created_at])
          @tags = options[:tags]

          @options = options
        end

        def attributes
          @options.keys + [:assignee_name]
        end
      end

      private

      def list
        @records
      end
    end
  end
end
