class User < ApplicationRecord
  include User::Validator
  include User::RoleInfoChecker

  enum role: { admin: 0, moderator: 1, executor: 2, advertiser: 3 }
  
  has_one :advertiser_info, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :advertiser_info  
  
end
