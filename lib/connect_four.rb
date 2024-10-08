# Main class to create a new game for connect four
class Grid
  attr_reader :grid

  def initialize(grid = [[], [], [], [], [], [], []], turn = 0)
    @grid = grid
    @turn = turn
  end

  def start
    p 'Connect four (selcet a number from 1 to 7 and try to get 4 in a row)'
    display_grid

    loop do
      p "#{choose_player} turn"
      player_input = gets.chomp.to_i
      next if add(player_input) == false

      display_grid

      if player_win? == true
        p "#{choose_player} wins"
        break
      end

      if game_draw? == true
        p 'Its a draw !'
        break
      end

      add_turn
    end
  end

  def game_draw?
    column_full = 0
    @grid.each do |column|
      column_full += 1 if column.length >= 6
    end
    return true if column_full >= 7

    false
  end

  def add(column_selection)
    return false if column_selection > 7
    return if column_full?(column_selection)

    @grid[column_selection - 1] << choose_player
  end

  def add_turn
    @turn += 1
  end

  def column_full?(column_selection)
    column = @grid[column_selection - 1]
    column.length >= 6
  end

  def display_grid
    tallest_column = 6

    display_list = []

    grid_to_display(tallest_column, display_list)

    display_list.each do |row|
      p row
    end
  end

  def grid_to_display(tallest_column, display_list)
    tallest_column.times do
      row_list = []

      @grid.each do |column|
        row_list << ' ' if column[tallest_column - 1].nil?
        next if column[tallest_column - 1].nil?

        row_list << column[tallest_column - 1]
      end

      display_list << row_list

      tallest_column -= 1
    end
  end

  def player_win?
    return true if check_vertical
    return true if check_horizontal
    return true if check_cross

    false
  end

  def check_vertical
    @grid.each do |column|
      x_sum = column.count('x')
      o_sum = column.count('o')
      next unless x_sum >= 4 || o_sum >= 4

      return true if four_items_in_row?(column)
    end
    false
  end

  def check_horizontal
    horizontal_row = [[], [], [], [], [], []]

    each_column_item_to_horizontal_row(horizontal_row)

    return true if four_items_in_horizontal_row?(horizontal_row)

    false
  end

  def all_equal?(arr)
    arr.uniq.size <= 1
  end

  def remove_arr_with_same_value(horizontal_row)
    horizontal_row.reject! { |element| all_equal?(element) }
    false
  end

  def each_column_item_to_horizontal_row(horizontal_row, row_counter = 0)
    6.times do
      @grid.each do |column|
        horizontal_row[row_counter] << column[row_counter]
      end
      row_counter += 1
    end

    remove_arr_with_same_value(horizontal_row)

    false
  end

  def four_items_in_horizontal_row?(horizontal_row)
    horizontal_row.each do |row|
      return true if four_items_in_row?(row)
    end
    false
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

    return true if move_cross_checker_vertical(check_diagonal_right_block, cross_right)
    return true if move_cross_checker_vertical(check_diagonal_left_block, cross_left)

    false
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
      return true if check_diagonal(counter_cross_v, counter_cross_h, check_diagonal_block)

      # counter_cross_h += 1
      counter_cross_h = check_diagonal_block.call(counter_cross_h)
    end

    false
  end

  def check_diagonal(counter_cross_v, counter_cross_h, check_diagonal_block)
    loop_counter = 0
    temp_cross = []
    loop do

      temp_value = @grid[counter_cross_h][counter_cross_v]

      temp_cross = [] if temp_cross.include?(nil)

      counter_cross_h = check_diagonal_block.call(counter_cross_h)
      counter_cross_v += 1

      if temp_value == choose_player
        temp_cross << temp_value
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
