# frozen_string_literal: true

require_relative '../connect_four'

describe Grid do
  subject(:grid_gameplay) { described_class.new }

  describe 'Creating 6 new arrays' do
    it 'creates new empty grid' do
      expect(grid_gameplay.grid).to eq([[], [], [], [], [], [], []])
    end
  end

  describe 'Adds a player to one column' do
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
  end
end
