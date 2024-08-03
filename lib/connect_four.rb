# Main class to create a new game for connect four
class Grid
  attr_reader :grid

  def initialize(grid = [[], [], [], [], [], [], []], turn = 0)
    @grid = grid
    @turn = turn
  end

  def add(column_selection)
    return if column_full?(column_selection)

    @grid[column_selection - 1] << choose_player
    add_turn
  end

  def add_turn
    @turn += 1
  end

  def column_full?(column_selection)
    column = @grid[column_selection - 1]
    column.length > 6
  end

  def choose_player
    player = %w[x o]
    player[@turn % 2]
  end
end
