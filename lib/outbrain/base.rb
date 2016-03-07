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
      errors.emtpy?
    end

    def persisted?
      try(:id).present?
    end
  end
end
