class City
  attr_reader   :name
  attr_accessor :visited

  def initialize(name)
    @name    = name
    @visited = false
  end

  def equals?(city)
    return nil if city.nil?
    @name == city.name
  end
end