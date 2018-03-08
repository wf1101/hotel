require 'pry'

class Admin
  attr_reader :rooms, :blocks

  def initialize
    @rooms = create_rooms
    @blocks = []
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
    # if date_valid?(start_date, end_date)
    #   next_room = @rooms.find{|room| room.available?(start_date, end_date)}
    # binding.pry
    raise ArgumentError.new("No available room") if find_available_rooms(start_date, end_date).empty?

    return find_available_rooms(start_date, end_date).first

    #   return next_room
    # end
  end

  def find_available_rooms(start_date, end_date)

    date_valid?(start_date, end_date)

    available_rooms = []
    @rooms.each do |room|
      if room.available?(start_date, end_date) && blocked?(start_date, end_date)
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

    block_rooms = find_block_rooms(start_date, end_date, number_of_rooms)

    new_block = Block.new(start_date, end_date, discounted_rate, block_rooms)

    block_rooms.each do |block_room|
      block_room.blocks << new_block
    end

    return new_block
  end

  def find_block_rooms(start_date, end_date, number_of_rooms)
    raise StandardError.new("Invalid number") if number_of_rooms > 5 || number_of_rooms < 3

    available_rooms = find_available_rooms(start_date, end_date)

    raise ArgumentError.new("No enough rooms") if available_rooms < number_of_rooms

    block_rooms = available_rooms.fisrt(number_of_rooms)

    return block_rooms
  end

  def blocked?(room, start_date, end_date)
    @blocks.each do |block|
      if block.start_date == start_date && black.end_date == end_date
        return true if block.rooms.include?(room)
      end
    end

    return false
  end

  def check_block_rooms(block)
    block.available_rooms
  end






end
