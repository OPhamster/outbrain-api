module Outbrain
  module Api
    class GeoLocation < Base
      PATH='locations/search'

      def self.search(query, limit = 50, exclude = "PostalCode")
        options = {term: query, limit: limit, exclude: exclude}
        Request.search(PATH, options, as: self)
      end
    end
  end
end
