# frozen_string_literal: true

require "json"

module Zen
  module Search
    class Helpers
      def self.fields_for(type)
        return Zen::Search::Services::Constants::USER_ATTRIBUTES if type == "Users"
        return Zen::Search::Services::Constants::TICKET_ATTRIBUTES if type == "Tickets"
      end

      def self.text_index(doc_id, doc, idx)
        idx[doc.downcase] ||= []
        idx[doc.downcase] << doc_id
      end

      def self.tokenized_index(doc_id, doc, idx)
        # 1 - tokenizer
        tokens = doc&.split(" ")

        # 2 - trim
        tokens = tokens.map(&:strip)

        # 3 - downcase all tokens
        tokens = tokens.map(&:downcase)

        # 4 - remove punctuation (not required, but just in case)
        tokens = tokens.map { |token| token.tr(",.!;:", "") }

        # 5 - Fill the value of the index
        tokens.each do |token|
          idx[token] ||= []
          idx[token] << doc_id
        end
      end

      def self.nillify_string(val)
        return nil if val == "nil"

        val
      end
    end
  end
end
