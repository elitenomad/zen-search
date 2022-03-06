# frozen_string_literal: true
# test.rb
require 'pry'
require_relative "search/version"
require "zen/search/users"
require "zen/search/tickets"
require "zen/search/helpers"
require "zen/search/parse"
require "zen/search/loader"
require "zen/search/updater"
require "zen/search/services/core"
require "zen/search/services/fields"
require "zen/search/services/print"
require "zen/search/services/users"
require "zen/search/services/tickets"
require "zen/search/services/constants"
require "zen/search/generate/user_indexer"
require "zen/search/generate/ticket_indexer"
require "zen/search/generate/indexer"
require "zen/search/cli"
require 'active_support/core_ext/hash/indifferent_access'

module Zen
  module Search
    class Error < StandardError; end
    class FileNotExistsError < StandardError; end
    class FileFormatNotSupportedError < StandardError; end

    # Your code goes here...
  end
end
