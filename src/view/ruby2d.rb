require 'ruby2d'
require 'byebug'
require_relative '../model/state'

module View
  class Ruby2dView
    def initialize(app)
      @pixel_size = 50
      @app = app
    end

    def start(state)
      extend Ruby2D::DSL
      set(
        title: "Snake",
        width: @pixel_size * state.grid.cols,
        height: @pixel_size * state.grid.rows)
      on :key_down do |event|
        # A key was pressed
        handle_key_event(event)
      end
      show
    end

    def render(state)
      extend Ruby2D::DSL
      close if state.game_over
      render_snake(state)
      render_food(state)
    end

    private

    def render_food(state)
      @food.remove if @food
      extend Ruby2D::DSL
      food = state.food
      # byebug
      @food = Square.new(
        x: food.col * @pixel_size,
        y: food.row * @pixel_size,
        size: @pixel_size,
        color: 'yellow'
      )
    end

    def render_snake(state)
      @snake_positions.each(&:remove) if @snake_positions
      extend Ruby2D::DSL
      snake = state.snake
      # byebug
      @snake_positions = snake.positions.map do |pos|
      Square.new(
        x: pos.col * @pixel_size,
        y: pos.row * @pixel_size,
        size: @pixel_size,
        color: 'green'
      )
      end
    end

    def handle_key_event(event)
      case event.key
      when 'up'
        #cambiar direccion hacia arriba
        @app.send_action(:change_direction, Model::Direction::UP)
      when 'down'
        #cambiar direccion hacia abajo
        @app.send_action(:change_direction, Model::Direction::DOWN)
      when 'left'
        #cambiar direccion hacia la izquierda
        @app.send_action(:change_direction, Model::Direction::LEFT)
      when 'right'
        #cambiar direccion hacia la derecha
        @app.send_action(:change_direction, Model::Direction::RIGHT)
      end
    end

  end
end