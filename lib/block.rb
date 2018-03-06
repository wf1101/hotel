class Block

  attr_reader :start_date, :end_date, :number, :rate

  def initialize(start_date, end_date, number_of_rooms, discounted_rate, rooms)
    @start_date = start_date
    @end_date = end_date
    @number = number_of_rooms
    @rate = discounted_rate
    @rooms = rooms
  end

  def group_room
    group = []



  end

end
