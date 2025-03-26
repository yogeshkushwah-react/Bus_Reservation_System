module ReservationsHelper
  def render_seats(seats, booked_seats)
    content_tag(:div, class: "seat-columns") do
      rows = seats.each_slice(4).to_a
      if rows.last.size == 1
        rows[-2] << rows.pop[0]
      elsif rows.last.size == 3
        rows[-2] << rows.pop[0..1]
      end

      rows.map do |row_seats|
        content_tag(:div, class: "seat-row") do
          row_seats.map do |seat|
            content_tag(:div, class: "rseat") do
              render_seat(seat, booked_seats)
            end
          end.join.html_safe
        end
      end.join.html_safe
    end
  end

  def render_seat(seat, booked_seats)
    label_class = "reserved" if booked_seats.include?(seat.id)
    check_box_options = { id: "seat_#{seat.id}" }
    check_box_options[:disabled] = true if booked_seats.include?(seat.id)
    check_box_tag("seat_ids[]", seat.id, booked_seats.include?(seat.id), check_box_options) +
    label_tag("seat_#{seat.id}", seat.seat_no, class: label_class)
  end
end
