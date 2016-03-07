module Outbrain
  module Api
    class Campaign < Base
      PATH = 'campaigns'

      def self.create(attributes)
        Request.create(PATH, { as: self, attributes: attributes })
      end
    end
  end
end
