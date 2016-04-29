module Outbrain
  class Request < Config
    def self.where(resource_path, query={}, options={})
      request_path = "/amplify/#{api_version}/#{resource_path}"
      query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
      request_path = request_path + '?' + query_string unless query_string.empty?
      response = api.get(request_path)
      resource_name = options.fetch(:resource_name, resource_path)
      meta_requests = options.fetch(:meta_resource_names)
      json_body = JSON.parse(response.body) # catch and raise proper api error

      fail InvalidOption 'requires an as option' unless options[:as]

      if response.status == 200
        meta_requests.each{|field| options[:as].define_singleton_method(field.to_sym) { json_body[field] } }
        json_body[resource_name].map do |obj|
          options[:as].new(obj)
        end
      else
        [json_body]
      end
    end

    def self.all(resource, options={})
      where(resource, {}, options)
    end

    def self.find(resource_path, id, options={})
      response = api.get("/amplify/#{api_version}/#{resource_path}/#{id}")
      json_body = JSON.parse(response.body)

      fail InvalidOption 'requires an as option' unless options[:as]

      if response.status == 200
        options[:as].new(json_body)
      else
        a = options[:as].new
        a.errors.push(json_body)
        a
      end
    end

    def self.create(resource, options={})
      attributes = options.fetch(:attributes, {})

      response = api.post("/amplify/#{api_version}/#{resource}", attributes.to_json)
      json_body = JSON.parse(response.body)

      if response.status == 200
        options[:as].new(json_body)
      else
        a = options[:as].new
        a.errors.push(json_body)
        a
      end
    end
  end
end
