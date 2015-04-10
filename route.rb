class Route
  attr_reader :to, :from, :length

  def initialize(from = nil, to = nil, length = 0)
    @from       = from
    @to         = to
    @length     = length
  end
end