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
    column.length >= 6
  end

  def player_win?
    pass
  end

  def check_vertical
    @grid.each do |column|
      x_sum = column.count('x')
      o_sum = column.count('o')
      next unless x_sum >= 4 || o_sum >= 4

      return true if four_items_in_row?(column)
    end
  end

  def check_horizontal
    horizontal_row = [[], [], [], [], [], []]

    each_column_item_to_horizontal_row(horizontal_row)

    # horizontal_row.reject! { |element| all_equal?(element) }

    true if four_items_in_horizontal_row?(horizontal_row)
  end

  def all_equal?(arr)
    arr.uniq.size <= 1
  end

  def remove_arr_with_same_value(horizontal_row)
    horizontal_row.reject! { |element| all_equal?(element) }
  end

  def each_column_item_to_horizontal_row(horizontal_row, row_counter = 0)
    6.times do
      @grid.each do |column|
        horizontal_row[row_counter] << column[row_counter]
      end
      row_counter += 1
    end

    remove_arr_with_same_value(horizontal_row)
  end

  def four_items_in_horizontal_row?(horizontal_row)
    horizontal_row.each do |row|
      return true if four_items_in_row?(row)
    end
  end

  def check_cross
    temp_cross = []
    cross_counter_horinzontal = 0
    cross_counter_vertical = 0
    horizontal_path = 0
    vertical_path = 0

    # move checker vertically
    3.times do
      # move checker horzontially
      4.times do
        # actual checker checking upper right
        4.times do
          temp_value = @grid[cross_counter_horinzontal][cross_counter_vertical]

          if temp_value == choose_player
            cross_counter_horinzontal += 1
            cross_counter_vertical += 1
            temp_cross << temp_value
            return true if temp_cross.length >= 4
          else
            temp_cross = []
          end
        end
        horizontal_path += 1
        cross_counter_horinzontal = 0
        cross_counter_vertical = 0
        cross_counter_horinzontal += horizontal_path
        cross_counter_vertical += horizontal_path
        cross_counter_vertical += vertical_path
      end
      vertical_path += 1
      cross_counter_vertical += vertical_path
    end
    false
  end

  def four_items_in_row?(column)
    temp_column = []

    column.each do |item|
      if item == choose_player
        temp_column << item
      else
        temp_column = []
      end

      return true if temp_column.length >= 4
    end
    false
  end

  def choose_player
    player = %w[x o]
    player[@turn % 2]
  end
end
