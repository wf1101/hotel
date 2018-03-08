require 'pry'
class Room
  attr_reader :id
  attr_accessor :rate
  def initialize(id)
    @id = id
    # @reservations = []
    @rate = 200
  end

  # def available?(start_date, end_date)
  #   @reservations.each do |reservation|
  #     if reservation.overlap?(start_date, end_date)
  #       return false
  #     end
  #   end
  #
  #   return true
  # end
  #
  # def find_reservation(date)
  #   reservations_on_date = @reservations.select {|reservation| (reservation.start_date...reservation.end_date).include?(date)}
  #   return reservations_on_date
  # end
  #
  # def add_reservation(reservation)
  #   @reservations << reservation
  # end

end
