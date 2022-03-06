require 'json'

module Zen
    module Search
      class Parse
        ACCEPTED_INSTRUCTION_FORMATS = [".json"]
        
        def self.run(file)
            if !ACCEPTED_INSTRUCTION_FORMATS.include?(File.extname(file))
              raise Zen::Search::FileFormatNotSupportedError.new("Only JSON files are supported currently.")
            end

            unless File.exist?(file)
              raise Zen::Search::FileNotExistsError.new("File does not exist.")
            end

            file = File.read(file)
            data = JSON.parse(file)

            return data
        end
      end
    end
  end