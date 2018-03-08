require_relative 'spec_helper'

describe "Block class" do

  s_hotel = Admin.new
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

end
