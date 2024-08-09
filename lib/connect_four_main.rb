require_relative 'connect_four'

game = Grid.new([%w[o], %w[x], %w[x o], %w[x x], %w[x o x], %w[o x o x], %w[x]])
game.check_cross
