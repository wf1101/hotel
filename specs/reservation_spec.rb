require_relative 'spec_helper'

describe "Reservation class" do
  describe "initialize" do
    it "can create an instance of reservation" do
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      room = Room.new(10)
      reservation = Reservation.new(date_in, date_out, room)

      reservation.must_be_instance_of Reservation
      reservation.must_respond_to :start_date
      reservation.must_respond_to :end_date
      reservation.must_respond_to :room
    end
  end

  describe "overlap? method" do
    it "return true if a given date range is overlapped with the reservation date range" do
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      room = Room.new(10)
      reservation = Reservation.new(date_in, date_out, room)

      date_in_1 = Date.new(2018,6,18)
      date_out_1 = Date.new(2018,6,23)

      result = reservation.overlap?(date_in_1, date_out_1)
      result.must_equal true
    end

    it "return false if a given date range is not overlapped with the reservation date range" do
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      room = Room.new(10)
      reservation = Reservation.new(date_in, date_out, room)

      date_in_1 = Date.new(2018,6,18)
      date_out_1 = date_in
      date_in_2 = date_out
      date_out_2 = Date.new(2018,6,29)

      date_in_3 = Date.new(2018,6,22)
      date_out_3 = Date.new(2018,6,24)
      date_in_4 = Date.new(2018,6,18)
      date_out_4 = Date.new(2018,6,30)

      result_1 = reservation.overlap?(date_in_1, date_out_1)
      result_2 = reservation.overlap?(date_in_2, date_out_2)
      result_3 = reservation.overlap?(date_in_3, date_out_3)
      result_4 = reservation.overlap?(date_in_4, date_out_4)

      result_1.must_equal false
      result_2.must_equal false
      result_3.must_equal true
      result_4.must_equal true
    end
  end

  describe "get_cost method" do
    it "returns the cost for the reservation" do
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      cost = (date_out - date_in) * 200
      room = Room.new(10)
      reservation = Reservation.new(date_in, date_out, room)
      reservation.get_cost.must_equal cost
    end
  end

end
