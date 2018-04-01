class Admin
  attr_reader :rooms_reservations, :blocks

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

  def date_valid?(start_date, end_date)
    if start_date > Date.today && end_date > start_date
      return true
    else
      raise StandardError.new("Invalid date")
    end
  end

  def find_available_rooms(start_date, end_date)
    date_valid?(start_date, end_date)
    available_rooms =  @rooms.find_all {|room| room.available?(start_date, end_date)}

    return available_rooms - list_blocked_rooms(start_date, end_date)
  end

  def find_next_room(start_date, end_date)
    available_rooms = find_available_rooms(start_date, end_date)
    raise ArgumentError.new("No available room") if available_rooms.empty?

    return available_rooms.first
  end

  def create_reservation(start_date, end_date)
    room = find_next_room(start_date, end_date)
    new_reservation = Reservation.new(start_date, end_date, room)
    room.add_reservation(new_reservation)

    return new_reservation
  end

  # def find_available_rooms(start_date, end_date)
  #   date_valid?(start_date, end_date)
  #   available_rooms = @rooms_reservations.keys
  #
  #   @rooms_reservations.each do |room, reservations|
  #     if !reservations.find{|reservation| reservation.overlap?(start_date, end_date)}.nil?
  #       available_rooms.delete(room)
  #     end
  #   end
  #
  #   return available_rooms - list_blocked_rooms(start_date, end_date)
  # end

  def check_reservations(date)
    raise StandardError.new("Invalid date") if date < Date.today

    res_on_date = []
    @rooms.each do |room|
      res_on_date << room.find_reservations(date)
    end
    # @rooms_reservations.values.each do |reservations|
    #   reservations.each do |reservation|
    #     date_range = (reservation.start_date...reservation.end_date)
    #     reservations_on_date << reservation if date_range.include?(date)
    #   end
    # end

    return res_on_date
  end

  # Blocks
  def find_block_rooms(start_date, end_date, number_of_rooms)
    raise ArgumentError.new("Invalid number, minimal 3 and maximum 5 rooms") if number_of_rooms > 5 || number_of_rooms < 3

    available_rooms = find_available_rooms(start_date, end_date)

    raise ArgumentError.new("No enough rooms") if available_rooms.length < number_of_rooms

    return  available_rooms.first(number_of_rooms)
  end

  def create_block(start_date, end_date, number_of_rooms, discounted_rate)
    block_rooms = find_block_rooms(start_date, end_date, number_of_rooms)
    new_block = Block.new(start_date, end_date, discounted_rate, block_rooms)
    @blocks << new_block

    return new_block
  end

  # available rooms in a block
  def list_blocked_rooms(start_date, end_date)
    date_valid?(start_date, end_date)

    blocked_rooms = []

    @blocks.each do |block|
      blocked_rooms << block.rooms
    end

    return blocked_rooms
  end

  # def check_block_rooms(block)
  #   return block.rooms.reject do |room|
  #     @rooms_reservations[room].any? do |res|
  #       res.start_date == block.start_date && res.end_date == block.end_date
  #     end
  #   end
  # end

  # def find_next_block_room(block)
  #   available_block_rooms = block.available_rooms
  #   raise ArgumentError.new("No available room in the block") if available_block_rooms.empty?
  #
  #   return available_block_rooms.first
  # end

  def reserve_block_room(block)
    room = block.find_next_room
    new_reservation = Reservation.new(block.start_date, block.end_date, room)
    room.add_reservation(new_reservation)
    return new_reservation
  end

end
