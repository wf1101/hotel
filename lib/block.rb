class Block

  attr_reader :start_date, :end_date, :rate, :rooms

  def initialize(start_date, end_date, discounted_rate, rooms)
    @start_date = start_date
    @end_date = end_date
    @rate = discounted_rate
    @rooms = rooms
  end

  def available_rooms
    @rooms.drop_while { |room| room.reservations.any? {|res| res.start_date == @start_date && res.end_date == @end_date} }
  end

  def find_next_room
    raise ArgumentError.new("No available room in the block") if available_rooms.empty?
    return available_rooms.first
  end
end
