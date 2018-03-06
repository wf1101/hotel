require 'pry'

class Hotel
  attr_reader :rooms

  def initialize
    @rooms = create_rooms
  end

  def create_rooms
    all_rooms = []
    20.times do |i|
      all_rooms << Room.new(i + 1)
    end

    return all_rooms
  end

  # return a new reservation
  def create_reservation(start_date, end_date)
    room = find_next_room(start_date, end_date)
    new_reservation = Reservation.new(start_date, end_date, room)
    room.reservations << new_reservation
    # binding.pry
    return new_reservation
  end

  def find_next_room(start_date, end_date)
    if date_valid?(start_date, end_date)
      next_room = rooms.find{|room| room.available?(start_date, end_date)}
      return next_room
    end
  end

  # return a list of reservations for the given date
  def check_reservations(date)
    raise StandardError.new("Invalid date") if date < Date.today

    reservations_on_date = []
    rooms.each do |room|
      reservations_on_date += room.find_reservations(date)
    end

    return reservations_on_date
  end

  def date_valid?(start_date, end_date)
    if start_date > Date.today && end_date > start_date
      return true
    else
      raise StandardError.new"Invalid date: it's allowed to book at least one night at least one day in advance"
    end

  end
end
