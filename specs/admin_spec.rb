require_relative 'spec_helper'
require 'pry'

describe "Admin class" do
  describe "initialize" do
    it "can create an instance of Admin with 20 rooms" do
      s_hotel = Admin.new
      s_hotel.must_be_instance_of Admin
      s_hotel.must_respond_to :rooms
      s_hotel.must_respond_to :blocks

      s_hotel.rooms.each do |room|
        room.must_be_instance_of Room
      end

      s_hotel.rooms.length.must_equal 20
    end
  end


  describe "date_valid? method" do
    it "returns true if date range is valid" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      s_hotel.date_valid?(date_in, date_out).must_equal true
    end

    it "raises StandardError if date range is including today or earlier than today" do
      s_hotel = Admin.new
      date_in = Date.today
      date_out = Date.new(2018,6,25)
      proc {
        s_hotel.date_valid?(date_in, date_out)
      }.must_raise StandardError
    end

    it "raises StandardError if date range is earlier than today" do
      s_hotel = Admin.new
      date_in = Date.new(2018,1,30)
      date_out = Date.new(2018,2,2)
      proc {
        s_hotel.date_valid?(date_in, date_out)
      }.must_raise StandardError
    end
  end

  describe "find_available_rooms method" do
    it "returns a list of rooms which are available for a given date range" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      7.times do
        s_hotel.create_reservation(date_in, date_out)
      end

      start_date = Date.new(2018,6,21)
      end_date = Date.new(2018,6,24)
      found_rooms = s_hotel.find_available_rooms(start_date, end_date)

      found_rooms.must_be_instance_of Array
      found_rooms.length.must_equal 13
      found_rooms.each do |room|
        room.must_be_instance_of Room
      end

    end
  end
  describe "find_next_room method" do
    s_hotel = Admin.new
    date_in = Date.new(2018,4,20)
    date_out = Date.new(2018,4,25)
    7.times do
      s_hotel.create_reservation(date_in, date_out)
    end
    next_room = s_hotel.find_next_room(date_in, date_out)

    it "returns an instance of room" do
      next_room.must_be_instance_of Room
      next_room.id.must_equal 8
    end

    it "returns correct room--testing normal cases" do
      date_in_2 = Date.new(2018,7,1)
      date_out_2 = Date.new(2018,7,3)

      next_room_2 = s_hotel.find_next_room(date_in_2, date_out_2)
      next_room_2.id.must_equal 1

      date_in_3 = Date.new(2018,5,1)
      date_out_3 = Date.new(2018,5,3)
      next_room_3 = s_hotel.find_next_room(date_in_3, date_out_3)
      next_room_3.id.must_equal 1
    end

    it "can raise an error when no room is available" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      20.times do
        s_hotel.create_reservation(date_in, date_out)
      end

      proc {
        s_hotel.find_next_room(date_in, date_out)
      }.must_raise ArgumentError
    end
  end

  describe "create_reservation method" do
    it "can create a new reservation" do
      s_hotel = Admin.new
      date_in = Date.new(2018,5,20)
      date_out = Date.new(2018,5,25)
      new_reservation = s_hotel.create_reservation(date_in, date_out)

      new_reservation.must_be_instance_of Reservation
    end

    it "can reserve a room starts at the same day that another reservation ends" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      6.times do
        s_hotel.create_reservation(date_in, date_out)
      end
      date_out_2 = Date.new(2018,6,27)
      date_out_3 = Date.new(2018,6,30)

      new_reservation_1 = s_hotel.create_reservation(date_out, date_out_2)
      new_reservation_2 = s_hotel.create_reservation(date_out_2, date_out_3)

      new_reservation_1.room.id.must_equal 1
      new_reservation_2.room.id.must_equal 1
    end

    it "raises a StandardError when reservaing a room within invalid dates" do
      s_hotel = Admin.new
      date_today = Date.today
      date_in = Date.new(2018,4,20)
      date_out = Date.new(2018,2,25)

      proc {
        s_hotel.create_reservation(date_in, date_out)
      }.must_raise StandardError

      proc {
        s_hotel.create_reservation(date_today, date_in)
      }.must_raise StandardError
    end

    it "will not reserve a room that is in a block" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      number = 4
      rate = 188
      w_block = s_hotel.create_block(date_in, date_out, number, rate)
      new_reservation = s_hotel.create_reservation(date_in, date_out)
      w_block.rooms.wont_include new_reservation.room
    end

    it "can raise an error when no room is available" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      20.times do
        s_hotel.create_reservation(date_in, date_out)
      end

      proc {
        s_hotel.create_reservation(date_in, date_out)
      }.must_raise ArgumentError
    end
  end

  describe "check_reservations method" do
    it "returns a list of reservations on date" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      7.times do
        s_hotel.create_reservation(date_in, date_out)
      end
      date_test = Date.new(2018,6,23)
      result = s_hotel.check_reservations(date_test)
      result.length.must_equal 7

      result.each do |item|
        item.must_be_instance_of Reservation
      end

    end
  end

  describe "find_block_rooms method" do
    it "can accurately find the given number of rooms to create a block" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      number = 4

      rooms = s_hotel.find_block_rooms(date_in, date_out, number)
      rooms.length.must_equal 4
      rooms.each do |room|
        room.must_be_instance_of Room
      end
    end

    it "won't include a room in other block" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      number = 4
      number_2 = 3
      rate = 188
      w_block = s_hotel.create_block(date_in, date_out, number, rate)

      rooms = s_hotel.find_block_rooms(date_in, date_out, number_2)
      w_block.rooms.each do |room|
        rooms.wont_include room
      end
    end
  end

  describe "create_block method" do
    it "can create a block of rooms when rooms are available" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      number = 4
      rate = 188
      w_block = s_hotel.create_block(date_in, date_out, number, rate)

      w_block.must_be_instance_of Block
      w_block.rooms.length.must_equal 4
    end

    it "can raise an error when rooms are not available" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      number = 4
      rate = 188

      17.times do
        s_hotel.create_reservation(date_in, date_out)
      end

      proc{
        s_hotel.create_block(date_in, date_out, number, rate)
      }.must_raise ArgumentError
    end

    it "can raise an error when creating a block of more than 5 rooms or less than 3 rooms" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      number_1 = 2
      number_2 = 7
      rate = 188

      proc{
        s_hotel.create_block(date_in, date_out, number_1, rate)
      }.must_raise ArgumentError

      proc{
        s_hotel.create_block(date_in, date_out, number_2, rate)
      }.must_raise ArgumentError
    end
  end

  describe "list_blocked_rooms method" do
    it "can return a list of blocked_rooms for certain date range" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      number = 4
      number_2 = 3
      rate = 188

      w_block = s_hotel.create_block(date_in, date_out, number, rate)
      v_block = s_hotel.create_block(date_in, date_out, number_2, rate)

      blocked_rooms = s_hotel.list_blocked_rooms(date_in, date_out)
      blocked_rooms.must_be_instance_of Array
      blocked_rooms.length.must_equal number + number_2
      (w_block.rooms + v_block.rooms).each do |w_v_room|
        blocked_rooms.must_include w_v_room
      end
    end
  end

  describe "reserve block room method" do
    it "can reserve a room in a block" do
      s_hotel = Admin.new
      date_in = Date.new(2018,6,20)
      date_out = Date.new(2018,6,25)
      number = 4
      rate = 188

      w_block = s_hotel.create_block(date_in, date_out, number, rate)
      new_res = s_hotel.reserve_block_room(w_block)
      new_res.must_be_instance_of Reservation
      w_block.available_rooms.length.must_equal 3
    end
  end

end
