class Event < ActiveRecord::Base
  belongs_to :registered_application
  # validates :name, length: { minimum: 3, maximum: 100 }, presence: true
  #validates_uniqueness_of :name, scope: :registered_application

  #default_scope { order('updated_at DESC') }
end
