module User::RoleInfoChecker
  extend ActiveSupport::Concern
  
  included do 
    before_save :check_role_info
  end

  def check_role_info
    if advertiser?
      build_advertiser_info if advertiser_info.nil?
    else
      advertiser_info.destroy if advertiser_info.present?
    end
  end

end