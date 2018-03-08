class Block

  attr_reader :start_date, :end_date, :rate, :rooms

  def initialize(start_date, end_date, discounted_rate, rooms)
    @start_date = start_date
    @end_date = end_date
    @rate = discounted_rate
    @rooms = rooms
  end

  def find_available_rooms(start_date, end_date)
    unbooked_rooms = []
    @rooms.each do |room|
      if room.available?(start_date, end_date)
        unbooked_rooms << room
      end
    end
    return unbooked_rooms
  end

  def find_next_room
    room = available_rooms.first
  end

  def reserve
    new_reservation = Reservation.new(@start_date, @end_date, next_room)

    next_room.reservations << new_reservation
    return new_reservation
  end

end
