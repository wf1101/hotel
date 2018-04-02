require_relative 'spec_helper'
require 'pry'
describe "Block class" do

  date_in = Date.new(2018,6,20)
  date_out = Date.new(2018,6,25)
  date_in_1 = Date.new(2018,6,26)
  date_out_1 = Date.new(2018,6,28)
  rooms = [Room.new(1), Room.new(2), Room.new(3)]
  rate = 188

  describe "initialize method" do
    it "can create an instance of Block" do
      x_block = Block.new(date_in, date_out, rate, rooms)
      x_block.must_be_instance_of Block
      x_block.must_respond_to :start_date
      x_block.must_respond_to :end_date
      x_block.must_respond_to :rooms
      x_block.must_respond_to :rate

      x_block.rooms.length.must_equal 3
    end

    it "has a collection of instances of Room" do
      y_block = Block.new(date_in, date_out, rate, rooms)
      y_block.must_respond_to :rooms
      y_block.rooms.each do |room|
        room.must_be_instance_of Room
      end
    end
  end

  describe "find available rooms" do
    it "it can find available rooms in the block" do
      w_block = Block.new(date_in_1, date_out_1, rate, rooms)
      w_block.available_rooms.length.must_equal 3
      room_1 = w_block.find_next_room
      new_res = Reservation.new(date_in_1, date_out_1, room_1)
      new_res.must_be_instance_of Reservation
      room_1.add_reservation(new_res)
      w_block.available_rooms.length.must_equal 2

      room_2 = w_block.find_next_room
      new_res_2 = Reservation.new(date_in_1, date_out_1, room_2)
      room_2.add_reservation(new_res)
      w_block.available_rooms.length.must_equal 1
    end
  end

  describe "find next room" do
    it "can return the first available room in the block" do
      h_block = Block.new(date_in, date_out, rate, rooms)
      h_block.find_next_room.id.must_equal 1
      room_1 = h_block.find_next_room
      new_res = Reservation.new(date_in, date_out, room_1)
      new_res.must_be_instance_of Reservation
      room_1.add_reservation(new_res)

      h_block.find_next_room.id.must_equal 2
      room_2 = h_block.find_next_room
      new_res = Reservation.new(date_in, date_out, room_2)
      new_res.must_be_instance_of Reservation
      room_2.add_reservation(new_res)

      h_block.find_next_room.id.must_equal 3
      room_3 = h_block.find_next_room
      new_res = Reservation.new(date_in, date_out, room_3)
      new_res.must_be_instance_of Reservation
      room_3.add_reservation(new_res)
    end

    it "will raise an error when there is no available room in the block" do
      proc {
        h_block.find_next_room
      }.must_raise StandardError
    end
  end

end
