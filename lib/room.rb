require 'pry'
class Room
  attr_reader :id
  attr_accessor :rate

  def initialize(id)
    @id = id
    @rate = 200
  end
end
