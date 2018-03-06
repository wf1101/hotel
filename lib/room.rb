require 'pry'
class Room
  attr_reader :id, :reservations
  def initialize(id)
    @id = id
    @reservations = []
  end

  def available?(start_date, end_date)
    flag = true
    @reservations.each do |reservation|
      if reservation.overlap?(start_date, end_date)
        flag = false
      end
    end

    return flag
  end

  def find_reservation(date)
    reservations_on_date = @reservations.select {|reservation| (reservation.start_date...reservation.end_date).include?(date)}
    return reservations_on_date
  end

  def add_reservation(reservation)
    @reservations << reservation
  end

end
