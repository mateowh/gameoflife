require_relative 'lib/game_generator.rb'

input = STDIN.read
puts GameGenerator.new(input).call
