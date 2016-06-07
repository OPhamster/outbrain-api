module Outbrain
  module Api
    class GeoLocation < Base
      PATH='locations/search'

      def self.search(query, limit = 10)
        options = {term: query, limit: limit}
        Request.search(PATH, options, as: self)
      end
    end
  end
end
