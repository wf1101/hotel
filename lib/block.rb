class Block

  attr_reader :start_date, :end_date, :rate, :rooms

  def initialize(start_date, end_date, discounted_rate, rooms)
    @start_date = start_date
    @end_date = end_date
    @rate = discounted_rate
    @rooms = rooms
  end

  def find_block_rooms

  end

  

end
