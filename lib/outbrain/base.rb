require 'hashie'

# remaking some of active-model here :-( but don't want rails

module Outbrain
  class Base < Hash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::Coercion

    attr_accessor :errors

    def initialize(attributes={})
      attributes.each do |key, value|
        self.send("#{key}=", value)
      end
      @errors = attributes.fetch(:errors, [])
      self
    end

    def valid?
      errors.empty?
    end

    def persisted?
      try(:id).present?
    end

    def extract_query_options(options, query_keys)
      options.partition{|option, v| query_keys.include?(option) && !v.nil?}
    end
  end
end
