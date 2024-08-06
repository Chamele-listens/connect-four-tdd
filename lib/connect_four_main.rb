require_relative 'connect_four'

game = Grid.new([%w[o], %w[x], %w[o x], %w[x o x], %w[o x o x], %w[o], %w[x]])
game.check_cross
