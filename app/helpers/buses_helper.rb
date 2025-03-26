module BusesHelper
  def main_image(bus)
    if bus.main_image.attached?
      image_tag bus.main_image, class: "img-fluid"
    else
      image_tag "logo.png", class: "img-fluid"
    end
  end
end
