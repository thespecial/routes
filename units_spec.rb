require './route.rb'
require './city.rb'
require './graph.rb'

describe 'Graph'  do

  before(:all) do
    #initialize cities
    @a, @b, @c, @d, @e = City.new('a') , City.new('b'), City.new('c'), City.new('d'), City.new('e')

    #create graph
    @graph = Graph.new

    #fill it in with routes according to task
    @graph.routes['a'] = [ Route.new(@a, @b, 5), Route.new(@a, @d, 5), Route.new(@a, @e, 7) ]
    @graph.routes['b'] = [ Route.new(@b, @c, 4) ]
    @graph.routes['c'] = [ Route.new(@c, @d, 8), Route.new(@c, @e, 2) ]
    @graph.routes['d'] = [ Route.new(@d, @c, 8), Route.new(@d, @e, 6) ]
    @graph.routes['e'] = [ Route.new(@e, @b, 3) ]
  end

  context 'vetify base' do
    it 'graph should be initialized' do
      expect(@graph.is_a? Graph).to be true
    end

    it 'routes table should be a hash' do
      expect(@graph.routes.is_a? Hash).to be true
    end

    it 'hash should not be empty' do
      expect(@graph.routes.empty?).to be false
    end

    it 'hash should contain key a' do
      expect(@graph.routes.has_key? 'a').to be true
    end

    it 'hash should contain array of routes by \'a\' key' do
      arr = @graph.routes['a']

      expect(arr.is_a? Array).to be true
      expect(arr.empty?).to be false

      is_route = false

      arr.each do |route|
        is_route = true if route.is_a? Route
      end

      expect(is_route).to be true
    end

  end

  context 'verify expected behaviour' do

    it '#1: Distance of the route A-B-C equals to 9 ' do
      expect(@graph.distance_for([ @a, @b, @c ])).to eq 9
    end

    it '#2: Distance of the route A-D equals to 5 ' do
      expect(@graph.distance_for([ @a, @d ])).to eq 5
    end

    it '#3: Distance of the route A-D-C equals to 13 ' do
      expect(@graph.distance_for([ @a, @d, @c ])).to eq 13
    end

    it '#4: Distance of the route A-E-B-C-D equals to 22' do
      expect(@graph.distance_for([ @a, @e, @b, @c, @d ])).to eq 22
    end

    it '#5: Distance of the route A-E-D has \'NO SUCH ROUTE\' as a result' do
      expect(@graph.distance_for([ @a, @e, @d ])).to eq 'NO SUCH ROUTE'
    end

    it '#6: Number of trips from C to C is 2' do
      expect(@graph.trips_num_with_stops_limited(@c, @c, 3)).to eq 2
    end

    it '#7: Number of trips from A to C is 4' do
      expect(@graph.trips_num_with_stops_limited(@a, @c, 4)).to eq 4
    end

    it '#8: Shrotest route length from A to C equals to 9' do
      expect(@graph.shortest_route(@a, @c)).to eq 9
    end

    it '#9: Shrotest route length from B to B equals to 9' do
      expect(@graph.shortest_route(@b, @b)).to eq 9
    end

    it '#10: Number of different routes from C to C with distance < 30 equals 7' do
      expect(@graph.routes_num_with_length_limited(@c, @c, 30)).to eq 7
    end

  end

end

describe 'City' do

  before(:all) do
    @city_a         = City.new 'a'
    @another_city_a = City.new 'a'
  end

  it 'should have correct name' do
    expect(@city_a.name).to eq 'a'
    expect(@another_city_a.name).to eq 'a'
  end

  it 'should be comparable' do
    expect(@city_a.equals? @another_city_a).to be true
  end
end


describe 'Route' do

  before(:all) do
    @A     = City.new 'a'
    @B     = City.new 'b'
    @route = Route.new(@A, @B, 5)
  end

  it 'should have city object as a \'from\' parameter' do
    expect(@route.from.is_a? City).to be true
    expect(@route.from.name).to eq 'a'
  end

  it 'should have city object as a \'to\' parameter' do
    expect(@route.to.is_a? City).to be true
    expect(@route.to.name).to eq 'b'
  end

  it 'should have correct length' do
    expect(@route.length).to eq 5
  end

end