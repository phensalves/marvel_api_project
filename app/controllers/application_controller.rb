class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

  def after_sign_in_path_for(resource_or_scope)
    marvel_characters_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
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

  def get_character
    Character.friendly.find(params[:id])
  end
end
