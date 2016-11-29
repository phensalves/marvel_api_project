class Marvel::CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  def index
    @characters = Character.paginate(page: params[:page], per_page: 10)

    if @characters.present? && less_than_1485?
      @characters = Api::CharacterManager.new
      @characters.create_characters
      @characters = Character.paginate(page: params[:page], per_page: 10)
    elsif @characters.present?
      @characters
    else
      @characters = Api::CharacterManager.new
      @characters.create_characters
      @characters = Character.paginate(page: params[:page], per_page: 10)
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

    def less_than_1485?
      Character.count < 1485
    end
end
