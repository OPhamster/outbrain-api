module Outbrain
  module Api
    class GeoLocation < Base
      PATH='locations/search'

      def self.search(request, query, limit = 50, exclude = "PostalCode")
        options = {term: query, limit: limit, exclude: exclude}
        request.search(PATH, options, as: self)
      end
    end
  end
end
