class Filter < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true

  def filter(_)
    raise 'Abstract Method'
  end

  scope :ages, -> {where(type: 'Age')}
  scope :breeds, -> {where(type: 'Breed')}
  scope :sizes, -> {where(type: 'Size')}
  scope :personalities, -> {where(type: 'Personality')}
  scope :plays, -> {where(type: 'Play')}
  scope :blocked_users, -> {where(type: 'BlockedUser')}
  scope :genders, -> {where(type: 'Gender')}
  scope :zipcodes, -> {where(type: 'Zipcode')}
end
