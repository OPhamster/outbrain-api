module Outbrain
  class Request < Config
    def initialize(attrs={})

    end

    def self.all(resource, options={})
      response = api.get("/amplify/#{api_version}/#{resource}")
      json_body = JSON.parse(response.body) # catch and raise proper api error
      json_body[resource].map do |obj|
        options[:as].new(obj)
      end
    end
  end
end
