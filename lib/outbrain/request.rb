module Outbrain
  class Request < Config
    def self.where(resource_path, query={}, options={})
      request_path = resource_path
      query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
      request_path = request_path + '?' + query_string unless query_string.empty?
      response = api.get(request_path)
      resource_name = options.fetch(:resource_name, resource_path)
      json_body = JSON.parse(response.body) # catch and raise proper api error

      fail InvalidOption 'requires an as option' unless options[:as]

      if response.status == 200
        Outbrain::Api::Relation
          .new(json_body.merge(relation_class: options[:as], relation_name: resource_name))
      else
        Outbrain::Api::Relation.new(errors: json_body)
      end
    end

    def self.all(resource, options={})
      where(resource, {}, options)
    end

    def self.find(resource_path, id, options={})
      response = api.get("#{resource_path}/#{id}")
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

      response = api.post("#{resource}", attributes.to_json)
      json_body = JSON.parse(response.body)

      if response.status == 200
        options[:as].new(json_body)
      else
        a = options[:as].new
        a.errors.push(json_body)
        a
      end
    end

    def self.update(resource_path, id, options={})
      attributes = options.fetch(:attributes, {})
      response = api.put("#{resource_path}/#{id}", attributes.to_json)
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
