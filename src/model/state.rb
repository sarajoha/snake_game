module Model
  module Direction
    UP = :up
    DOWN = :down
    RIGHT = :right
    LEFT = :left
  end

  class Coord < Struct.new(:row, :col)
  end

  class Food < Coord
  end

  class Snake < Struct.new(:positions)
  end

  class Grid < Struct.new(:rows, :cols)
  end

  class State < Struct.new(:snake, :food, :grid, :next_direction, :game_over) #position matters
  end

  def self.initial_state
    Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(0, 1),
      ]),
      Model::Food.new(3, 3),
      Model::Grid.new(8, 10),
      Direction::DOWN,
      false
    )
  end
end