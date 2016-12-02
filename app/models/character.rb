class Character < ActiveRecord::Base
  extend FriendlyId

  has_many :comics

  validates :name, uniqueness: true

  friendly_id :name, use: :slugged

end
