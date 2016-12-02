class Api::V1::CharactersController < ApplicationController
  
  def index
    @characters = Character.paginate(page: params[:page], per_page: 10)
    get_all_characters unless @characters.present?
  end

  def show
    @character = get_character
    get_all_character_comics unless @character.comics.present?
  end

  private

    def get_character
      Character.where(marvel_id: params[:marvel_id]).first
    end
end