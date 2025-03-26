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

  def user_image(user)
    if user.user_image.attached?
      image_tag user.user_image, class: "img-fluid img-radius rounded-circle"
    else
      image_tag "user.png", class: "img-fluid"
    end
  end
end
