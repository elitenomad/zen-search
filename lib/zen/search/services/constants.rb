module Zen
    module Search
        module Services
            class Constants
                USER_ATTRIBUTES = %w[_id name verified created_at]
                TICKET_ATTRIBUTES = %w[_id type subject assignee_id tag created_at]
                TICKET_PRINT_ATTRIBUTES = %w[_id type subject assignee_id assignee_name tag created_at]
            end
        end
    end
end