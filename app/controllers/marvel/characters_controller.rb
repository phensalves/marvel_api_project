class Marvel::CharactersController < ApplicationController
  before_action :get_character, only: [:show]
  before_action :authenticate_user!

  def index
    @characters = Character.paginate(page: params[:page], per_page: 10)

    if @characters.present?
      @characters
    else
      get_all_characters
    end
  end

  def show
    @character = get_character
    get_all_character_comics unless @character.comics.present?
  end

  private

    def get_character
      Character.friendly.find(params[:id])
    end

    def character_params
      params.fetch(:character, {})
    end

    def get_all_characters
      @characters = Api::CharacterManager.new
      @characters.create_characters
      @characters = Character.paginate(page: params[:page], per_page: 10)
    end

    def get_all_character_comics
      @character = get_character
      @manager   = Api::CharacterManager.new({character: @character.id})
      @manager.associate_comics
    end

end
