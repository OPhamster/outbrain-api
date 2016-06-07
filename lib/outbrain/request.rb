module Outbrain
  class Request < Config
    def self.where(resource_path, query={}, options={})
      fail InvalidOption 'requires an as option' unless options[:as]
      json_body, status = get_json(resource_path, query)

      if status == 200
        resource_name = options.fetch(:resource_name, resource_path)
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

    ## For api methods that return arrays without a root element or meta info
    def self.search(path, query={}, options={})
      json_body, status = get_json(path, query)
      resource_class = options.fetch(:as)
      if status == 200
        json_body.map{|e| resource_class.new(e)}
      else
        Outbrain::Api::Relation.new(errors: json_body)
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
      wrap_response = options.fetch(:wrap_response, true)
      response = api.put("#{resource_path}/#{id}", attributes.to_json)
      success = (response.status == 200)
      return success  unless wrap_response
      json_body = JSON.parse(response.body)
      if success
        options[:as].new(json_body)
      else
        a = options[:as].new
        a.errors.push(json_body)
        a
      end
    end

    def self.get_json(root_path, query)
      query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
      path = query_string.empty? ? root_path : "#{root_path}?#{query_string}"
      response = api.get(path)
      [JSON.parse(response.body), response.status] # catch and raise proper api error
    end
  end
end
