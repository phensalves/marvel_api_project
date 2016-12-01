json.characters @characters do |character|
  json.marvel_id                character.marvel_id
  json.name                     character.name
  json.description              character.description
  json.image                    character.image
  json.modified_at              character.updated_at
end

# json.array! @characters, partial: 'characters/character', as: :character