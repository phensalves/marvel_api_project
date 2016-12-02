class Api::V1::CharactersController < CharactersBaseController
  skip_before_action :verify_authenticity_token
  
  def index
    super
  end

  def show
    @character = get_character_by_marvel_id
    get_all_character_comics unless @character.comics.present?
  end

  def create
    @character = Character.create(character_params)
    if @character.save
      render json: { message: "Personagem criado com sucesso!" }, status: 200
    else
      render json: { message: "Não foi possível cadastrar o personagem."}, status: 422
    end
  end

  def update
    @character = get_character_by_marvel_id
    @character.slug = nil
    if @character.update_attributes(character_params)
      render json: { message: "Personagem alterado com sucesso!"}, status: 200
    else
      render json: { message: "Não foi possível atualizar o personagem."}, status: 422
    end
  end

  def destroy
    @character = get_character_by_marvel_id
    if @character.present? && @character.destroy
      render json: { message: "Personagem deletado com sucesso!"}, status: 200
    else
      render json: { message: "Não foi possível deletar o personagem."}, status: 422
    end
  end

  private

  def character_params
    @params = { name: params[:name], 
                description: params[:description], 
                marvel_id: params[:marvel_id]
              }
  end

  def get_character_by_marvel_id
    Character.where(marvel_id: params[:marvel_id]).first
  end

  def get_all_character_comics
    @character = get_character_by_marvel_id
    @manager   = Api::CharacterManager.new({character: @character.id})
    @manager.associate_comics
  end
end