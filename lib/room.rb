class Room

  attr_reader :id
  attr_accessor :rate
  attr_reader :reservations
  def initialize(id)
    @id = id
    @rate = 200
    @reservations = []
  end

  def available?(start_date, end_date)
    return true if @reservations.find { |res| res.overlap?(start_date, end_date)}.nil?

    return false
  end

  def find_reservations(date)
    res_on_date = @reservations
    res_on_date.find_all { |res| (res.start_date...res.end_date).include?(date)}

    return res_on_date
   end

   def add_reservation(reservation)
   @reservations << reservation
   end
   
end
