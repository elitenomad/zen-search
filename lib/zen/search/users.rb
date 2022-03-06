# frozen_string_literal: true

require "date"

module Zen
  module Search
    class Users
      include Enumerable

      def initialize(records)
        @records = records.map do |record|
          Zen::Search::User.new(record.with_indifferent_access)
        end
      end

      def each(&block)
        list.each(&block)
      end

      def schema
        @records.first.attributes
      end

      # Class hierarchy which represents User
      # elements of the Users class.
      #
      # == Initialize:
      # id:: User ID
      # name:: User name
      # created_at::  User created at timestamp
      # verified:: Boolean value to inform if users is verified
      #
      class Zen::Search::User
        attr_reader :id, :name, :created_at, :verified, :options
        attr_accessor :tickets

        def initialize(options)
          @id = options[:_id]
          @name = options[:name]
          @created_at = DateTime.parse(options[:created_at])
          @verified = options[:verified]
          @tickets ||= []

          @options = options
        end

        def attributes
          @options.keys + [:tickets]
        end
      end

      private

      def list
        @records
      end
    end
  end
end
