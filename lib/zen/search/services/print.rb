# frozen_string_literal: true

require "tty-table"
require "tty-pager"

module Zen
  module Search
    module Services
      class Print
        def self.list(values)
          if values.size <= 0
            puts "No results found"
            return
          end

          table = TTY::Table.new
          values.each do |value|
            table << [value]
          end

          puts table.render(:ascii)
        end

        def self.objects(results)
          if results.size <= 0
            puts "No results found"
            return
          end

          prompt = ->(_page) { "Page -#{page_num}- Press enter to continue" }
          pager = TTY::Pager.new(width: 250, prompt: prompt)
          begin
            headers = results&.first&.attributes || []
            table = TTY::Table.new(header: headers)

            results.each do |result|
              cols = []
              headers.each do |header|
                col_val = header == "_id" ? result.id : result.send(:"#{header}")
                cols << col_val
              end

              table << cols
            end

            # Just hard coded based on max attributes for a resource
            table_renderer = table.render(:ascii) do |renderer|
              renderer.border.separator = ->(row) { row != 0 && ((row + 1) % 6).zero? }
            end

            pager.puts table_renderer
          rescue TTY::Pager::PagerClosed
            # the user closed the paginating tool
          ensure
            pager.close
          end
        end
      end
    end
  end
end
