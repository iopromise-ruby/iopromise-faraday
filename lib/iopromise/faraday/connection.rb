# frozen_string_literal: true

require 'faraday'

require_relative 'promise'

module IOPromise
  module Faraday
    class Connection < ::Faraday::Connection
      def initialize(*)
        super
        
        @parallel_manager = FaradayPromise.parallel_manager
      end

      def in_parallel(manager = nil)
        # not supported, we're always in parallel
      end
    end
  end
end
