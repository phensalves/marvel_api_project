module Api
  class CharacterManager

    API_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/marvel_configs.yml")["marvel_api"]

    def initialize options={}
      @ts                   = "#{API_CONFIG['ts']}"
      @api_key              = "#{API_CONFIG['api_key']}"
      @hash                 = "#{API_CONFIG['secret_hash']}"
      @limit                = "#{API_CONFIG['limit']}"
      @character            = load_character(options[:character])
      @characters_uri       = URI.parse("#{API_CONFIG['url']}")
      @character_comics_uri = URI.parse("#{API_CONFIG['url']}" + '/' + "#{@character.marvel_id}" + '/comics') if @character
    end

    def create_characters
      get_characters

      characters = @marvel_characters["data"]["results"]
      characters.each do |character|
        marvel_character =  Character.new(
                              name:         character["name"],
                              description:  character["description"],
                              image:        character["thumbnail"]["path"].to_s,
                              updated_at:   character["modified"].to_date,
                              marvel_id:    character["id"]
                            )
        marvel_character.save
      end
    end

    def associate_comics
      get_character_comics
      
      comics = @associate_comics["data"]["results"]

      comics.each do |comic|
        marvel_comic = Comic.new(
                        title:            comic["title"],
                        cover_number:     comic["issueNumber"],
                        image:            comic["thumbnail"]["path"].to_s,
                        character_id:     @character.id   
                      )
        marvel_comic.save
      end
    end

    private

    def get_characters
      call_marvel @characters_uri
      
      @marvel_characters = JSON.parse(@response.body)
    end

    def get_character_comics
      call_marvel @character_comics_uri

      @associate_comics = JSON.parse(@response.body)
    end

    def load_character character
      begin
        Character.friendly.find(character)
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end

    def call_marvel uri
      params       = {ts: @ts, apikey: @api_key, hash: @hash, limit: @limit}
      uri.query    = URI.encode_www_form(params)
      http         = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request      = Net::HTTP::Get.new(uri.request_uri)
      @response     = http.request(request)
      @response.body
    end

  end
end