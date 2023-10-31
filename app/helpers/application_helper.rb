module ApplicationHelper
  def user_profile_type
    if current_user.admin?
      profile_path
    elsif current_user.bus_owner?
      busowner_profile_path
    else
      user_profile_path
    end
  end
end
