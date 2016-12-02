json.marvel_id          @character.marvel_id
json.name               @character.name
json.description        @character.description
json.modified_at        @character.updated_at
json.image              @character.image

json.comics @character.comics do |comic|
  json.title            comic.title
  json.cover_number     comic.cover_number
  json.image            comic.image
end