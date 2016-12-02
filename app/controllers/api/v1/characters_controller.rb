class Api::V1::CharactersController < CharactersBaseController
  
  def index
    super
  end

  def show
    @character = get_character_by_marvel_id
    get_all_character_comics unless @character.comics.present?
  end

  private

  def get_character_by_marvel_id
    Character.where(marvel_id: params[:marvel_id]).first
  end

  def get_all_character_comics
    @character = get_character_by_marvel_id
    @manager   = Api::CharacterManager.new({character: @character.id})
    @manager.associate_comics
  end
end