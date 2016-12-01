module ApplicationHelper
  def display_last_update character
    return '---' unless character.updated_at < Time.now

    l character.updated_at, format: :simple
  end
end
