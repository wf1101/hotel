require_relative 'spec_helper'

describe "Room class" do
  describe "initialize method" do
    it "can create an instance of Room" do
      [1, 2, 3, 4, 5].each do |n|
        Room.new(n).must_be_instance_of Room
      end
    end
    #
    # it "the instance of Room has a collections of reservations with a defaulted value of emply array" do
    #   result = Room.new(1).reservations
    #   result.must_be_instance_of Array
    #   result.length.must_equal 0
    # end
  end

  # describe "available? method" do
  #   it "returns a boolean value whether the room is available at a given date range" do
  #     room = Room.new(1)
  #     date_in = Date.new(2018,6,20)
  #     date_out = Date.new(2018,6,25)
  #     result = room.available?(date_in, date_out)
  #     result.must_equal true
  #
  #     reservation = Reservation.new(date_in, date_out, room)
  #     room.add_reservation(reservation)
  #
  #     result_1 = room.available?(date_in, date_out)
  #     result_1.must_equal false
  #   end
  # end

  # describe "find_reservations mthod" do
  #   it "returns a list of reservations for a specific date" do
  #     room = Room.new(1)
  #     date_in = Date.new(2018,6,20)
  #     date_out = Date.new(2018,6,28)
  #
  #     reservation = Reservation.new(date_in, date_out, room)
  #     room.add_reservation(reservation)
  #
  #     date = Date.new(2018,6,25)
  #     result = room.find_reservation(date)
  #     result.must_be_instance_of Array
  #     result[0].must_be_instance_of Reservation
  #     result.length.must_equal 1
  #   end
  # end

end
