module User::Validator
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  included do 
    validates :email, presence: true, uniqueness: true
    validates :role, presence: true
  end

end