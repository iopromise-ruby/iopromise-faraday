# frozen_string_literal: true

require_relative 'connection'

module IOPromise
  module Faraday
    class Client
      def initialize(url = nil, options = {}, &block)
        options = ::Faraday.default_connection_options.merge(options)
        @conn = ::IOPromise::Faraday::Connection.new(url, options) do |faraday|
          faraday.adapter :typhoeus
          block.call(faraday) unless block.nil?
        end
      end

      (::Faraday::METHODS_WITH_QUERY + ::Faraday::METHODS_WITH_BODY).each do |method|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{method}(*args, **kwargs)
            FaradayPromise.new(@conn.#{method}(*args, **kwargs))
          end
        RUBY
      end
    end
  end
end
