require_relative 'connect_four'

game = Grid.new([%w[x], %w[o x], %w[o x x], %w[o o x x], %w[], %w[], %w[]])
game.check_cross
