require 'pry'

class Admin
  attr_reader :rooms_reservations, :blocks

  def initialize
    @rooms_reservations = create_rooms
    @blocks = []
  end

  # create a hash storing 20 pairs key - room;value - list of reservations
  def create_rooms
    all_rooms = {}
    20.times do |i|
      all_rooms[Room.new(i + 1)] = []
    end

    return all_rooms
  end

  def create_reservation(start_date, end_date)
    room = find_next_room(start_date, end_date)
    new_reservation = Reservation.new(start_date, end_date, room)
    @rooms_reservations[room] << new_reservation

    return new_reservation
  end

  def find_next_room(start_date, end_date)
    # if date_valid?(start_date, end_date)
    #   next_room = @rooms.find{|room| room.available?(start_date, end_date)}
    # binding.pry
    available_rooms = find_available_rooms(start_date, end_date)
    raise ArgumentError.new("No available room") if available_rooms.empty?

    return available_rooms.first

    #   return next_room
    # end
  end

  def find_available_rooms(start_date, end_date)

    date_valid?(start_date, end_date)

    available_rooms = @rooms_reservations.keys

    @rooms_reservations.each do |room, reservations|
      if !reservations.find{|reservation| reservation.overlap?(start_date, end_date)}.nil?
        available_rooms.delete(room)
      end
    end

    return available_rooms - list_blocked_rooms(start_date, end_date)
  end

  def check_reservations(date)
    raise StandardError.new("Invalid date") if date < Date.today

    reservations_on_date = []
    @rooms_reservations.values.each do |reservations|
      reservations.each do |reservation|
        date_range = (reservation.start_date...reservation.end_date)
        reservations_on_date << reservation if date_range.include?(date)
      end
    end

    # rooms.each do |room|
    #   reservations_on_date += room.find_reservation(date)
    # end

    return reservations_on_date
  end

  def date_valid?(start_date, end_date)
    if start_date > Date.today && end_date > start_date
      return true
    else
      raise StandardError.new("Invalid date")
    end
  end

  def create_block(start_date, end_date, number_of_rooms, discounted_rate)
    block_rooms = find_block_rooms(start_date, end_date, number_of_rooms)
    new_block = Block.new(start_date, end_date, discounted_rate, block_rooms)
    @blocks << new_block

    return new_block
  end

  def find_block_rooms(start_date, end_date, number_of_rooms)
    raise ArgumentError.new("Invalid number, minimal 3 and maximum 5 rooms") if number_of_rooms > 5 || number_of_rooms < 3

    available_rooms = find_available_rooms(start_date, end_date)

    raise ArgumentError.new("No enough rooms") if available_rooms.length < number_of_rooms

    block_rooms = available_rooms.first(number_of_rooms)

    return block_rooms
  end

  def list_blocked_rooms(start_date, end_date)
    date_valid?(start_date, end_date)

    blocked_rooms = []
    @blocks.each do |block|
      if start_date < block.end_date || end_date > block.start_date
        blocked_rooms += block.rooms
      end
    end

    return blocked_rooms
  end

  def check_block_rooms(block)
    unbooked_rooms = block.rooms
    unbooked_rooms.each do |room|
      @rooms_reservations[room].each do |reservation|
        if reservation.start_date == block.start_date && reservation.end_date == block.end_date
          unbooked_rooms.delete(room)
        end
      end
    end
    # binding.pry
    return unbooked_rooms
  end

  def find_next_block_room(block)
    available_block_rooms = check_block_rooms(block)
    raise ArgumentError.new("No available room in the block") if available_block_rooms.empty?

    return available_block_rooms.first
  end

  def reserve_block_room(block)
    room = find_next_block_room(block)
    new_reservation = Reservation.new(block.start_date, block.end_date, room)
    @rooms_reservations[room] << new_reservation
    return new_reservation
  end

end
