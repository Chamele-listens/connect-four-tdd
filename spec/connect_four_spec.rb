# frozen_string_literal: true

require_relative '../lib/connect_four'

describe Grid do
  subject(:grid_gameplay) { described_class.new }

  describe 'Creating 6 new arrays' do
    it 'creates new empty grid' do
      expect(grid_gameplay.grid).to eq([[], [], [], [], [], [], []])
    end
  end

  describe '#add' do
    it 'adds x on 1st column' do
      column_selection = 1
      grid_gameplay.add(column_selection)
      expect(grid_gameplay.grid).to eq([['x'], [], [], [], [], [], []])
    end

    it 'adds x on 2nd column' do
      column_selection = 2
      grid_gameplay.add(column_selection)
      expect(grid_gameplay.grid).to eq([[], ['x'], [], [], [], [], []])
    end

    it 'adds x on the same column twice after 3 turns' do
      column_selection = 1
      grid_gameplay.add(column_selection)
      grid_gameplay.add(2)
      grid_gameplay.add(column_selection)
      expect(grid_gameplay.grid).to eq([%w[x x], ['o'], [], [], [], [], []])
    end
  end

  describe '#column_full?' do
    it 'returns false when column is not full' do
      column_selection = 1
      expect(grid_gameplay.column_full?(column_selection)).to be false
    end

    subject(:column_gameplay_full) { described_class.new([%w[x x x x x x], [], [], [], [], [], []]) }

    it 'returns true when column is full' do
      column_selection = 1
      expect(column_gameplay_full.column_full?(column_selection)).to be true
    end
  end

  describe '#four_items_in_row?' do
    column_win = %w[x x x x]
    it 'returns true when column has 4 x in a row' do
      expect(grid_gameplay.four_items_in_row?(column_win)).to be true
    end

    column_lose = %w[x x x o x]
    it 'returns false when x are not in a row of 4' do
      expect(grid_gameplay.four_items_in_row?(column_lose)).to be false
    end
  end

  describe '#check_vertical' do
    subject(:grid_vertical_call) { described_class.new([%w[x x x x], [], [], [], [], [], []]) }
    it 'calls #four_items_in_row? when column has 4 x or o' do
      expect(grid_vertical_call).to receive(:four_items_in_row?).with(%w[x x x x])
      grid_vertical_call.check_vertical
    end

    subject(:grid_vertical_not_call) { described_class.new([%w[x x x], [], [], [], [], [], []]) }
    it 'doesnt call #four_items_in_row? when column doesnt have 4 x or o' do
      expect(grid_vertical_not_call).not_to receive(:four_items_in_row?).with(%w[x x x])
      grid_vertical_not_call.check_vertical
    end
  end

  describe '#each_column_item_to_horizontal_row' do
    subject(:grid_horizontal) { described_class.new([%w[x x], %w[x], %w[x], %w[x o], %w[o], %w[o], %w[o]]) }

    it 'append each item from column to form an a list of horizontal items' do
      horizontal_row = [[], [], [], [], [], []]
      a = [%w[x x x x o o o], ['x', nil, nil, 'o', nil, nil, nil]]
      expect(grid_horizontal.each_column_item_to_horizontal_row(horizontal_row)).to eq(a)
    end
  end

  describe '#check_diagonal_right' do
    subject(:grid_cross_X) { described_class.new([%w[x], %w[o x], %w[o x x], %w[o o x x], %w[], %w[], %w[]]) }
    it 'returns true when x are cross' do
      expect(grid_cross_X.check_diagonal_right([], 0)).to be true
    end

    subject(:grid_cross_lost) { described_class.new([%w[o], %w[x], %w[x], %w[x], %w[o], %w[o], %w[x]]) }
    it 'returns false when x are not cross' do
      expect(grid_cross_lost.check_diagonal_right([], 0)).to be false
    end
  end

  describe '#check_cross' do
    subject(:grid_cross_horizontal) do
      described_class.new([%w[o], %w[x], %w[o x], %w[x o x], %w[o x o x], %w[o], %w[x]])
      expect(grid_cross_horizontal.check_cross).to be true
    end
  end
end
