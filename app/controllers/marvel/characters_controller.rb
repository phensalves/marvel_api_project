class Marvel::CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  def index
    if @characters
      @characters = Character.paginate(page: params[:page], per_page: 20)
    else
      @characters = Api::CharacterManager.new
      @characters.create_characters
      @characters = Character.paginate(page: params[:page], per_page: 20)
    end
  end

  def show
    @character = set_character
  end

  private
    def set_character
      @character = Character.find(params[:id])
    end

    def character_params
      params.fetch(:character, {})
    end
end
