require_relative 'spec_helper'

describe "Block class" do

  s_hotel = Hotel.new
  date_in = Date.new(2018,6,20)
  date_out = Date.new(2018,6,25)
  rooms = [Room.new(1), Room.new(2), Room.new(3)]
  rate = 188

  describe "initialize method" do
    it "can create an instance of Block" do
      w_block = Block.new(date_in, date_out, rate, rooms)

      w_block.must_be_instance_of Block
      w_block.rooms.length.must_equal 3

    end

    it "has a collection of instances of Room" do
      w_block = Block.new(date_in, date_out, rate, rooms)
      w_block.must_respond_to :rooms
      w_block.rooms.each do |room|
        room.must_be_instance_of Room
      end

    end
  end

  describe "available_rooms method" do
    it "can return a list of available rooms in the block" do
      w_block = Block.new(date_in, date_out, rate, rooms)
      w_rooms = w_block.available_rooms(date_in, date_out)
      w_rooms.must_be_instance_of Array
      w_rooms.length.must_equal 3
    end

  end

  describe "reserve method" do
    it "can reserve a room which is available" do
      w_block = Block.new(date_in, date_out, rate, rooms)
      new_reservation
    end
  end


end
