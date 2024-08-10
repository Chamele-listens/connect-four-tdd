require_relative 'connect_four'

game = Grid.new([%w[o o x x], %w[x o x], %w[o x], %w[x], %w[x], %w[o], %w[o]])
game.check_cross
