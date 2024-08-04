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
    column = %w[x x x x]
    it 'returns true when column has 4 x in a row' do
      expect(grid_gameplay.four_items_in_row?(column)).to be true
    end
  end
end
