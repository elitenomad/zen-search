# frozen_string_literal: true

module Zen
  module Search
    module Services
      class Users
        # == Zen::Search::Resources::User
        # id, name, created_at, verified

        def self.find_by_id(user_index, id)
          user = user_index.id_index[id]
          return [] if user.nil?

          [user]
        end

        def self.find_by_name(user_index, name)
          user_index.name_index[name&.downcase] || []
        end

        def self.find_by_created_at(user_index, date)
          users = user_index.id_index.values.flatten
          users.select { |user| user.created_at >= date }
        end

        def self.find_after_date(user_index, date)
          users = user_index.id_index.values.flatten
          users.select { |user| user.created_at >= date }
        end

        def self.find_by_verified(user_index, verified)
          user_index.verfied_index[:"#{verified}"] || []
        end

        def self.find_verified_users(user_index, verified)
          user_index.verfied_index[:"#{verified}"] || []
        end
      end
    end
  end
end
