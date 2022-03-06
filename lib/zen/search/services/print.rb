# frozen_string_literal: true

require "tty-table"

module Zen
  module Search
    module Services
      class Print
        def self.list(values)
          table = TTY::Table.new
          values.each do |value|
            table << [value]
          end

          puts table.render(:ascii)
        end

        def self.objects(results)
          return if results.size <= 0

          headers = results.first.attributes
          table = TTY::Table.new(header: headers)

          results.each do |result|
            cols = []
            headers.each do |header|
              col_val = header == "_id" ? result.id : result.send(:"#{header}")
              cols << col_val
            end

            table << cols
          end

          puts table.render(:ascii)
        end
      end
    end
  end
end
