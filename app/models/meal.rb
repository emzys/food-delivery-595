class Meal
  attr_reader :name, :price
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end

  def self.headers
    ['id', 'name', 'price']
  end

  # you have access to all instance
  # variables inside methods
  def build_row
    [@id, @name, @price]
  end
end
