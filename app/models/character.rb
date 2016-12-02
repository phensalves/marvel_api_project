class Character < ActiveRecord::Base
  extend FriendlyId

  validates :name, uniqueness: true

  friendly_id :name, use: :slugged

end
