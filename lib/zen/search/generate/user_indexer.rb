# frozen_string_literal: true

module Zen
  module Search
    module Generate
      class UserIndexer
        attr_reader :id_index, :name_index, :verfied_index

        def initialize(users)
          @users = users

          # Indexes
          @id_index ||= {}
          @name_index ||= {}
          @verfied_index ||= {
            true: [],
            false: [],
            nil: []
          }
        end

        def for_id!
          @users.each do |user|
            @id_index[user.id] = user
          end
        end

        def for_name!
          @users.each do |user|
            Zen::Search::Helpers.text_index(user, user&.name, @name_index)
            Zen::Search::Helpers.tokenized_index(user, user&.name, @name_index)
          end
        end

        def for_verified!
          @users.each do |user|
            @verfied_index[:"#{user.verified}"] << user unless user.verified.nil?
            @verfied_index[:nil] << user if user.verified.nil?
          end
        end

        def index!
          for_id!
          for_name!
          for_verified!
        end
      end
    end
  end
end
