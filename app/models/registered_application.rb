class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, length: { minimum: 3, maximum: 100 }, presence: true
  validates :url, length: { minimum: 3, maximum: 100 }, presence: true
  validates_uniqueness_of :url

  scope :visible_to, -> (current_user) { where(user: current_user) }

end
