module Outbrain
  class InvalidOption < StandardError; end

  class Request < Config
    def initialize(api, api_version)
      super(api, api_version)
    end

    def where(resource_path, query = {}, options = {})
      unless options[:as].present?
        byebug
        raise InvalidOption, 'requires an as option'
      end
      json_body, status = get_json(resource_path, query)

      if status == 200
        resource_name = options.fetch(:resource_name, resource_path)
        Outbrain::Api::Relation
          .new(json_body.merge(relation_class: options[:as], relation_name: resource_name))
      else
        Outbrain::Api::Relation.new(errors: json_body)
      end
    end

    def all(resource, options = {})
      where(resource, {}, options)
    end

    # token retrieval
    def get(resource, attributes)
      user_name = attributes['user_name'] || attributes[:user_name]
      user_password = attributes['user_password'] || attributes[:user_password]
      api.basic_auth user_name, user_password

      response = api.get(resource)
      json_body = JSON.parse(response.body)
    end

    def find(resource_path, id, options = {})
      response = api.get("#{resource_path}/#{id}")
      json_body = JSON.parse(response.body)

      raise InvalidOption 'requires an as option' unless options[:as]

      if response.status == 200
        options[:as].new(json_body)
      else
        a = options[:as].new
        a.errors.push(json_body)
        a
      end
    end

    ## For api methods that return arrays without a root element or meta info
    def search(path, query = {}, options = {})
      json_body, status = get_json(path, query)
      resource_class = options.fetch(:as)
      if status == 200
        json_body.map { |e| resource_class.new(e) }
      else
        Outbrain::Api::Relation.new(errors: json_body)
      end
    end

    def create(resource, options = {})
      attributes = options.fetch(:attributes, {})

      response = api.post(resource.to_s, attributes.to_json)
      json_body = JSON.parse(response.body)

      if response.status == 200
        options[:as].new(json_body)
      else
        a = options[:as].new
        a.errors.push(json_body)
        a
      end
    end

    def update(resource_path, id, options = {})
      attributes = options.fetch(:attributes, {})
      wrap_response = options.fetch(:wrap_response, true)
      response = api.put("#{resource_path}/#{id}", attributes.to_json)
      success = (response.status == 200)
      return success unless wrap_response
      json_body = JSON.parse(response.body)
      if success
        options[:as].new(json_body)
      else
        a = options[:as].new
        a.errors.push(json_body)
        a
      end
    end

    def get_json(root_path, query)
      query_string = query.map { |k, v| "#{k}=#{v}" }.join('&')
      path = query_string.empty? ? root_path : "#{root_path}?#{query_string}"
      response = api.get(path)
      [JSON.parse(response.body), response.status] # catch and raise proper api error
    end
  end
end
