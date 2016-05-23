class RegisteredApplication < ActiveRecord::Base
  belongs_to :user

  validates :name, length: { minimum: 3, maximum: 100 }, presence: true
  validates :url, length: { minimum: 3, maximum: 100 }, presence: true
  validates_uniqueness_of :url, scope: :user 

end
