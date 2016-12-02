class Marvel::CharactersController < ApplicationController
  before_action :authenticate_user!

  def index
    @characters = Character.paginate(page: params[:page], per_page: 10)
    get_all_characters unless @characters.present?
  end

  def show
    @character = get_character
    get_all_character_comics unless @character.comics.present?
  end

end
