module Api
  class MarvelApiManager
    
    API_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/marvel_configs.yml")["marvel_api"]

    def process
      get_characters
      binding.pry
      @character.update_attributes(
        name:         
        description:  
        image:              
      )
    end

    private
    def get_characters
      request = Net::HTTP::Get.new("#{API_CONFIG['url']}", "#{API_CONFIG['port']}", "#{API_CONFIG['characters']}", "#{API_CONFIG['timestamp']}", "#{API_CONFIG['api_key']}", "#{API_CONFIG['hash']}")

      puts request.body
    end
  end
end