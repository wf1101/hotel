class Reservation
  attr_reader :start_date, :end_date, :room
  def initialize(start_date, end_date, room)

    @start_date = start_date
    @end_date = end_date
    @room = room
  end

  def overlap?(first_date, second_date)
    flag = true
    return false if first_date >= @end_date || second_date <= @start_date
    return flag
  end

  def get_cost
    return (end_date - start_date) * 200
  end

end
