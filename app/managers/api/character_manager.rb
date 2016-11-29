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
      uri      = URI.parse("#{API_CONFIG['url']}")
      port     = "#{API_CONFIG['port']}"
      params   = {timestamp: "#{API_CONFIG['timestamp']}", api_key: "#{API_CONFIG['api_key']}", hash: "#{API_CONFIG['secret_hash']}"}
      
      http_req = Net::HTTP.new(uri, port)

      http_req.use_ssl = true

      http_req.start { |http|

        request = Net::HTTP::Get.new(uri, params)
        
        response = http.request request # Net::HTTPResponse object
      }

      if response.body.include?("{") and response.body.include?("}")
        json = JSON.parse(response.body)
      else
        response.body
      end

    end
  end
end