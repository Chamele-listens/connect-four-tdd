require_relative 'connect_four'

game = Grid.new([%w[o], %w[x x], %w[o o x], %w[x o x x], %w[x x o x x], %w[o], %w[x]])
game.check_cross
