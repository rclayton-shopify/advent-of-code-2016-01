# frozen_string_literal: true

# read in direction inputs
INPUT_FILE = 'advent_201601_INPUT.txt'
directions = File.read(INPUT_FILE).split(', ')

# keeps track of facing info. Name and co-ordinate manipulation
facings = [
  { name: 'North', x: 0, y: 1 },
  { name: 'East', x: 1, y: 0 },
  { name: 'South', x: 0, y: -1 },
  { name: 'West', x: -1, y: 0 }
]
current_facing = 0
current_position = { x: 0, y: 0 }
visited = []

# makes it easier to create a readable output
turns = { L: 'left', R: 'right' }

directions.each do |direction|
  # first character is the turn direction, rest of string is amount moved
  turn = direction.slice(0)
  speed = direction.slice(1..-1)

  # change facing based on turn direction
  current_facing = turn == 'L' ? current_facing - 1 : current_facing + 1
  # (% array.length) is a neat way to wrap around array instead
  # of going out of bounds. ex: 4 becomes 0, -1 becomes 3
  current_facing = current_facing % facings.length

  # move in direction one block at a time and record each location visited
  speed.to_i.times do
    current_position[:x] += facings[current_facing][:x]
    current_position[:y] += facings[current_facing][:y]
    visited.push(x: current_position[:x], y: current_position[:y])
  end

  # print out some useful info
  puts "Turning #{turns[turn.to_sym]} to face " \
  "#{facings[current_facing][:name]}. Moving #{speed} blocks to position " \
  "#{current_position[:x]}:#{current_position[:y]}"
end

# find first revisted location
first_visted = visited.detect { |e| visited.count(e) > 1 }

puts 'The Easter Bunny HQ is ' \
"#{current_position[:x].abs + current_position[:y].abs} blocks away."

puts 'The first revisted block is ' \
"#{first_visted[:x].abs + first_visted[:y].abs} blocks away."
