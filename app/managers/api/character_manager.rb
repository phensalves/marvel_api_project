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
      binding.pry
      req = Net::HTTP::Get.new(uri, params)
      puts req.body

      uri      = URI("#{API_CONFIG['url']}")
      params   = {timestamp: "#{API_CONFIG['timestamp']}", api_key: "#{API_CONFIG['api_key']}", hash: "#{API_CONFIG['secret_hash']}"}
      http     = Net::HTTP.new(uri, "#{API_CONFIG['port']}", params )

      binding.pry

      http.open_timeout = 600
      http.read_timeout = 600

      response = http.start { |http| http.request(req) }

      if response.body.include?("{") and response.body.include?("}")
        json = JSON.parse(response.body)
      else
        response.body
      end

    end
  end
end