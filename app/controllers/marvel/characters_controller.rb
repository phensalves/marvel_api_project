class Marvel::CharactersController < CharacterBaseController
  before_action :authenticate_user!

  def index
    super
  end

  def show
    super
  end

end
