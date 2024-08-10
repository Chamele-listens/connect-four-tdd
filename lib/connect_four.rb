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
    # lambda for checking weather a player has made a cross
    # diagonally right and checking all right side

    check_diagonal_right_block = lambda do |counter_cross_h|
      counter_cross_h + 1
    end

    # lambda for checking if a player made a cross
    # diagonally left and checking all left side

    check_diagonal_left_block = lambda do |counter_cross_h|
      counter_cross_h - 1
    end

    # 2 boolean value for checking left cross and right cross:
    # - false for right cross check
    # - true for left cross check

    cross_right = false
    cross_left = true

    move_cross_checker_vertical(check_diagonal_right_block, cross_right)
    move_cross_checker_vertical(check_diagonal_left_block, cross_left)
  end

  def move_cross_checker_vertical(check_diagonal_block, cross_left)
    counter_cross_v = 0

    3.times do
      return true if move_cross_checker_horizontal(counter_cross_v, check_diagonal_block, cross_left)

      counter_cross_v += 1
    end

    false
  end

  def move_cross_checker_horizontal(counter_cross_v, check_diagonal_block, cross_left)
    counter_cross_h = 0
    counter_cross_h = 6 if cross_left == true

    4.times do
      return true if check_diagonal_right(counter_cross_v, counter_cross_h, check_diagonal_block)

      # counter_cross_h += 1
      counter_cross_h = check_diagonal_block.call(counter_cross_h)
    end

    false
  end

  def check_diagonal_right(counter_cross_v, counter_cross_h, check_diagonal_block, counter_cross = 0)
    loop_counter = 0
    temp_cross = []
    # counter_cross_h = 7 if cross_left == true
    loop do
      # return false if @grid[counter_cross_h][counter_cross_v].nil?

      temp_value = @grid[counter_cross_h][counter_cross_v]

      temp_cross = [] if temp_cross.include?(nil)

      # return false if temp_value.nil?

      counter_cross += 1
      # counter_cross_h += 1
      counter_cross_h = check_diagonal_block.call(counter_cross_h)
      counter_cross_v += 1

      if temp_value == choose_player
        temp_cross << temp_value
        counter_cross = 0 if counter_cross >= 4
        return true if temp_cross.length >= 4
      else
        temp_cross = []
      end

      loop_counter += 1

      break if loop_counter >= 4
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
