class Block

  attr_reader :start_date, :end_date, :rate, :rooms

  def initialize(start_date, end_date, number_of_rooms, discounted_rate, rooms)
    @start_date = start_date
    @end_date = end_date
    @rate = discounted_rate
    @rooms = rooms
  end

  def get_room_status
    room_status = {}
    @rooms.each do |room|
      room_status[room] = :available
    end
    return room_status
  end

  def track_room_status(room)
    get_room_status[room] = :unavailable
  end

  def available_rooms
    unbooked_rooms = []
    get_room_status.each do |room, status|
      unbooked_rooms << room if status == :available
    end
    return unbooked_rooms
  end

  def next_room
    room = available_rooms.sample
  end

  def reserve(@start_date, @end_date, next_room)
    new_reservation = Reservation.new(@start_date, @end_date, next_room)

    next_room.reservations << new_reservation
    return new_reservation
  end

end
