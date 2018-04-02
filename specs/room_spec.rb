require_relative 'spec_helper'
require 'pry'
describe "Room class" do
  describe "initialize method" do
    it "can create an instance of Room" do
      [1, 2, 3, 4, 5].each do |n|
        Room.new(n).must_be_instance_of Room
        Room.new(n).must_respond_to :id
        Room.new(n).must_respond_to :rate
        Room.new(n).must_respond_to :reservations
      end
    end
  end

  describe "instance method rate" do
    it "allows admin to change the rate for the room" do
      room_1 = Room.new(1)
      room_1.rate.must_equal 200

      room_1.rate = 188
      room_1.rate.must_equal 188
    end
  end

  describe "available? method" do
    it "can return true if the room is available at a given date range" do
      room_1 = Room.new(1)
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      new_res = Reservation.new(date_in, date_out, room_1)
      date_in_2 = Date.new(2018,6,25)
      date_out_2 = Date.new(2018,6.29)
      room_1.available?(date_in_2, date_out_2).must_equal true
    end

    it "can return false if the room is not available at a given date range" do
      room_1 = Room.new(1)
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      new_res = Reservation.new(date_in, date_out, room_1)
      room_1.available?(date_in, date_out).must_equal true
    end
  end

  describe "find_reservations method" do
    it "can return the reservations at a given date" do
      room_1 = Room.new(1)
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      date_in_2 = Date.new(2018,6,25)
      date_out_2 = Date.new(2018,6,29)
      new_res = Reservation.new(date_in, date_out, room_1)
      room_1.reservations << new_res
      new_res_2 = Reservation.new(date_in_2, date_out_2, room_1)
      room_1.reservations << new_res_2

      room_1.find_reservations(Date.new(2018,6,27)).must_equal new_res_2
    end
  end


end
