class Character < ActiveRecord::Base
  validates :name, uniqueness: true
end
