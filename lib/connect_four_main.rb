require_relative 'connect_four'

game = Grid.new([%w[o], %w[o], %w[o], %w[x x], %w[o x x], %w[o o x x], %w[x o o x]])
game.check_cross
