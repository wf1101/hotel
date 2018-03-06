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

  def create_reservation(start_date, end_date)
    room = find_next_room(start_date, end_date)
    new_reservation = Reservation.new(start_date, end_date, room)
    room.reservations << new_reservation

    return new_reservation
  end

  def find_next_room(start_date, end_date)
    if date_valid?(start_date, end_date)
      next_room = rooms.find{|room| room.available?(start_date, end_date)}

      raise ArgumentError.new("No available room") if next_room.nil?

      return next_room
    end
  end

  def find_available_rooms(start_date, end_date)
    available_rooms = []
    @rooms.each do |room|
      if room.available?(start_date, end_date)
        available_rooms << room
      end
    end

    return available_rooms
  end

  def check_reservations(date)
    raise StandardError.new("Invalid date") if date < Date.today

    reservations_on_date = []
    rooms.each do |room|
      reservations_on_date += room.find_reservation(date)
    end

    return reservations_on_date
  end

  def date_valid?(start_date, end_date)
    if start_date > Date.today && end_date > start_date
      return true
    else
      raise StandardError.new("Invalid date: it's allowed to book one night minimal at least one day in advance")
    end
  end

  def create_block(start_date, end_date, number_of_rooms, discounted_rate)
    raise StandardError.new("Invalid number") if number_of_rooms > 5 || number_of_rooms < 3





  end


end
