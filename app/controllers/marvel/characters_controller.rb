class Marvel::CharactersController < ApplicationController
  before_action :get_character, only: [:show, :edit, :update, :destroy]

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
      @character = Character.find_by(params[:id])
    end

    def character_params
      params.fetch(:character, {})
    end

end
