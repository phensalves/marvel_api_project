class Marvel::CharactersController < CharactersBaseController
  before_action :authenticate_user!

  def index
    super
  end

  def show
    @character = get_character
    get_all_character_comics unless @character.comics.present?
  end

  private

    def get_character
      Character.friendly.find(params[:id])
    end

    def get_all_character_comics
      @character = get_character
      @manager   = Api::CharacterManager.new({character: @character.id})
      @manager.associate_comics
    end
end
