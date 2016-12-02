module Marvel::CharactersHelper
  def display_last_update character
    return '---' unless character.updated_at < Time.now

    l character.updated_at, format: :simple
  end

  def has_any_comics? character
    t(:comics_blank, scope: [:comics]) unless character.comics.present?
  end
end
