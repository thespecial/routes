NO_ROUTE = 'NO SUCH ROUTE'

class Graph
  attr_accessor :routes

  def initialize
    @routes = {}
  end

  #cities - array of cities
  def distance_for(cities)
    #if incorrect input data - return 0
    #no routes between 1 or 0 cities :)
    return 0 if ((cities.size < 2) || (cities.size == 0))

    i = length = stops = 0

    #verify, if city exists in graphs hash
    while i < cities.size - 1 do
      if @routes.has_key? cities[i].name
        #if exists, get all routes for the city
        routes = @routes[cities[i].name]

        #for each route check if destination 'to'
        #equal to next city in cities input array
        routes.each do |route|
          if route.to.equals? cities[i+1]
            length += route.length
            stops  += 1
            break
          end
        end
      else
        return NO_ROUTE
      end

      i += 1
    end

    return NO_ROUTE if stops != cities.size-1

    length
  end

  #finds trips number with set maximal amount of stops
  def trips_num_with_stops_limited(from = nil, to = nil, max_stops = 0)
    find_routes(from, to, 0, max_stops)
  end

  #finds shortest route
  def shortest_route(from = nil, to = nil)
    find_shortest_route(from, to, 0, 0)
  end

  #finds routes with limited length
  def routes_num_with_length_limited(from = nil, to = nil, max_length = 0)
    find_routes_num(from, to, 0, max_length)
  end

  private
  def find_routes(from = nil, to = nil, stops = 0, max_stops = 0)
    return NO_ROUTE if ((from.nil?) || (to.nil?) || (max_stops == 0))

    trips = 0

    #if 'from' and 'to' cities exist in routes hash
    if (@routes.has_key? from.name) && (@routes.has_key? to.name)
      stops += 1

      #stops count should not be greater than max_stops specified
      return 0 if stops > max_stops

      from.visited = true #we visit 'from' city

      routes = @routes[from.name] #get all routes by city key

      routes.each do |route|
        #if destination equal to route destination
        #increment trips count and proceed to next route

        if route.to.equals? to
          trips += 1

        #if destination not match to route destination
        #and not visited, try to achieve destination recursively
        elsif not route.to.visited
          trips += find_routes(route.to, to, stops, max_stops)
          stops -= 1
        end
      end

    else
      return NO_ROUTE
    end

    from.visited = false
    trips

  end

  #finds shortest route 'from' => 'to'
  def find_shortest_route(from = nil, to = nil, length = 0, min = 0)
    return NO_ROUTE if ((from.nil?) || (to.nil?))

    #if 'from' and 'to' cities exist in routes hash
    if (@routes.has_key? from.name) && (@routes.has_key? to.name)
      from.visited = true #we visit 'from' city

      routes = @routes[from.name] #get all routes by city key

      routes.each do |route|
        #if 'to' not visited and its a destination
        #calculate route length
        length += route.length if (route.to.equals? to) || (not route.to.visited)

        #if destination achieved
        if route.to.equals? to
          #verify length and set min value, return the result
          min = length if (min == 0) || (length < min)
          from.visited = false
          return min

        #if route not visited
        elsif not route.to.visited
          #find min path recursively
          min = find_shortest_route(route.to, to, length, min)
          length -= route.length
        end
      end

    else
      return NO_ROUTE
    end

    from.visited = false
    min
  end

  def find_routes_num(from, to, length, max_length)
    return NO_ROUTE if (from.nil? || to.nil? || (max_length == 0) || (max_length.nil?))

    variants = 0 # possible routes count

    #if 'from' and 'to' cities exist in routes hash
    if (@routes.has_key? from.name) && (@routes.has_key? to.name)
      routes = @routes[from.name] #get all routes by city key

      routes.each do |route|
        length += route.length

        # if distance less then max length
        # continue search
        if length <= max_length
          if route.to.equals? to
            variants += 1
            # recursively find a way
            variants += find_routes_num(route.to, to, length, max_length)
          else
            # recursively find a way
            variants += find_routes_num(route.to, to, length, max_length)
            length   -= route.length #decrement path length because we go
          end
        else
          length -= route.length
        end
      end
    else
      return NO_ROUTE
    end

    variants
  end

end