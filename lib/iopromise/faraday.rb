# frozen_string_literal: true

require 'iopromise'
require_relative 'faraday/client'

module IOPromise
  module Faraday
    class << self
      def new(url = nil, options = {}, &block)
        ::IOPromise::Faraday::Client.new(url, options, &block)
      end
    end
  end
end
