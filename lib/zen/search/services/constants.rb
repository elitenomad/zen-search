# frozen_string_literal: true

module Zen
  module Search
    module Services
      class Constants
        USER_ATTRIBUTES = %w[_id name verified created_at].freeze
        TICKET_ATTRIBUTES = %w[_id type subject assignee_id tags created_at].freeze
        TICKET_PRINT_ATTRIBUTES = %w[_id type subject assignee_id assignee_name tags].freeze
      end
    end
  end
end
