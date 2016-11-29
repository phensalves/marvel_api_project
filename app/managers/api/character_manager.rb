module Api
  class CharacterManager

    API_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/marvel_configs.yml")["marvel_api"]

    def initialize options={}
      @name        = options[:character_name]
      @description = options[:description]
      @image       = options[:thumb]
    end

    def process
      get_characters
      @character.update_attributes(
        name:         @name,        
        description:  @description,
        image:        @iamge
      )
    end

    private
    def get_characters
      uri          = URI.parse("#{API_CONFIG['url']}")
      params       = {timestamp: "#{API_CONFIG['timestamp']}", api_key: "#{API_CONFIG['api_key']}", hash: "#{API_CONFIG['secret_hash']}"}
      uri.query    = URI.encode_www_form(params)
      http         = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request      = Net::HTTP::Get.new(uri.request_uri)

      response     = http.request(request)

      response.body

      if response.body.include?("{") and response.body.include?("}")
        json = JSON.parse(response.body)
      else
        response.body
      end

    end
  end
end