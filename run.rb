#!/usr/bin/env ruby
require './route.rb'
require './city.rb'
require './graph.rb'

a = City.new 'a'
b = City.new 'b'
c = City.new 'c'
d = City.new 'd'
e = City.new 'e'


graph = Graph.new

graph.routes['a'] = [ Route.new(a, b, 5), Route.new(a, d, 5), Route.new(a, e, 7) ]
graph.routes['b'] = [ Route.new(b, c, 4) ]
graph.routes['c'] = [ Route.new(c, d, 8), Route.new(c, e, 2) ]
graph.routes['d'] = [ Route.new(d, c, 8), Route.new(d, e, 6) ]
graph.routes['e'] = [ Route.new(e, b, 3) ]

puts "Run Output:"
puts "#1:#{graph.distance_for([ a, b, c ])}"
puts "#2:#{graph.distance_for([ a, d ])}"
puts "#3:#{graph.distance_for([ a, d, c ])}"
puts "#4:#{graph.distance_for([ a, e, b, c, d ])}"
puts "#5:#{graph.distance_for([ a, e, d ])}"
puts "#6:#{graph.trips_num_with_stops_limited(c, c, 3)}"

## I found 4 routes according to input data
## A-B-C, A-D-E-B-C, A-E-B-C, A-D-C
puts "#7:#{graph.trips_num_with_stops_limited(a, c, 4)}", "(error in task, pls find out comments inside run.rb)"
puts "#8:#{graph.shortest_route(a, c)}"
puts "#9:#{graph.shortest_route(b, b)}"
puts "#10:#{graph.routes_num_with_length_limited(c, c, 30)}"
