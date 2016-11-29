module Api
  class CharacterManager

    API_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/marvel_configs.yml")["marvel_api"]

    def initialize
      @ts          = "#{API_CONFIG['ts']}"
      @api_key     = "#{API_CONFIG['api_key']}"
      @hash        = "#{API_CONFIG['secret_hash']}"
      @limit       = "#{API_CONFIG['limit']}"
    end

    def create_characters
      get_characters

      characters = @marvel_characters["data"]["results"]

      characters.each do |character|
        next if already_exists(character)

        marvel_character =  Character.new(
                              name:         character["name"],
                              description:  character["description"],
                              image:        character["thumbnail"]["path"].to_s
                            )
        marvel_character.save
      end
    end

    private
    def get_characters
      uri          = URI.parse("#{API_CONFIG['url']}")
      params       = {ts: @ts, apikey: @api_key, hash: @hash, limit: @limit}
      uri.query    = URI.encode_www_form(params)
      http         = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request      = Net::HTTP::Get.new(uri.request_uri)
      response     = http.request(request)
      response.body

      if response.body.include?("{") and response.body.include?("}")
        @marvel_characters = JSON.parse(response.body)
      else
        response.body
      end

    end

    def already_exists character
      (Character.where(name: character["name"]).first).present? ? true : false
    end

  end
end