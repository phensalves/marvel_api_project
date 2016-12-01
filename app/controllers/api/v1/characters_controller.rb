class Api::V1::CharactersController < ApplicationController
  
  def index
    @characters = Character.paginate(page: params[:page], per_page: 10)

      if @characters.present?
        @characters
      else
        @characters = Api::CharacterManager.new
        @characters.create_characters
        @characters = Character.paginate(page: params[:page], per_page: 10)
      end
  end

  def show
    @character = get_character
  end

  private

    def get_character
      Character.where(marvel_id: params[:marvel_id]).first
    end
end