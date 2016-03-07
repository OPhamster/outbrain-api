require 'hashie'

module Outbrain
  class Base < Hash
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::Coercion
  end
end
