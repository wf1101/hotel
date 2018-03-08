require_relative 'spec_helper'

describe "Room class" do
  describe "initialize method" do
    it "can create an instance of Room" do
      [1, 2, 3, 4, 5].each do |n|
        Room.new(n).must_be_instance_of Room
        Room.new(n).must_respond_to :id
        Room.new(n).must_respond_to :rate
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

end
