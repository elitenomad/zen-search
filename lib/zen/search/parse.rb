# frozen_string_literal: true

require "json"

module Zen
  module Search
    class Parse
      ACCEPTED_INSTRUCTION_FORMATS = [".json"].freeze

      def self.run(file)
        unless ACCEPTED_INSTRUCTION_FORMATS.include?(File.extname(file))
          raise Zen::Search::FileFormatNotSupportedError, "Only JSON files are supported currently."
        end

        raise Zen::Search::FileNotExistsError, "File does not exist." unless File.exist?(file)

        file = File.read(file)
        JSON.parse(file)
      end
    end
  end
end
