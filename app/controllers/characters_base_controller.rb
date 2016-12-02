class CharactersBaseController < ApplicationController
  def index
    @characters = Character.paginate(page: params[:page], per_page: 10)
    get_all_characters unless @characters.present?
  end
end