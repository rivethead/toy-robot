defmodule ToyRobot.Robot do
  alias ToyRobot.Robot

  defstruct north: 0, east: 0, facing: :north

  @doc """
  Moves the robot forward in the direction it is facing. The number of spaces to move is based on the value of `number_of_spaces`. The default value of `number_of_spaces` is 1

  ## Examples
    iex> alias ToyRobot.Robot
    ToyRobot.Robot
    iex> robot = %Robot{north: 0, facing: :north}
    %Robot{north: 0, east: 0, facing: :north}
    iex> robot |> Robot.move
    %Robot{north: 1, east: 0, facing: :north}
    iex> robot |> Robot.move(3)
    %Robot{north: 3, east: 0, facing: :north}
  """
  def move(%Robot{facing: facing} = robot, number_of_spaces \\ 1) do
    case facing do
      :north -> robot |> move_north(number_of_spaces)
      :south -> robot |> move_south(number_of_spaces)
      :east -> robot |> move_east(number_of_spaces)
      :west -> robot |> move_west(number_of_spaces)
    end
  end

  @doc """
  Turns the robot around

  ## Examples

    iex> alias ToyRobot.Robot
    ToyRobot.Robot
    iex> robot = %Robot{north: 0, facing: :north}
    %Robot{north: 0, east: 0, facing: :north}
    iex> robot |> Robot.uturn
    %Robot{north: 0, east: 0, facing: :south}
  """
  def uturn(%Robot{facing: facing} = robot) do
    new_facing = case facing do
      :north -> :south
      :east -> :west
      :south -> :north
      :west -> :east
    end

    %Robot{robot | facing: new_facing}

  end

  @doc """
  Turns a robot left

  ## Examples

  iex> alias ToyRobot.Robot
  ToyRobot.Robot
  iex> robot = %Robot{facing: :north}
  %Robot{facing: :north}
  iex> robot |> Robot.turn_left
  %Robot{facing: :west}
  """
  def turn_left(%Robot{facing: facing} = robot) do
    new_facing = case facing do
      :north -> :west
      :east -> :north
      :south -> :east
      :west -> :south
    end

    %Robot{robot | facing: new_facing}
  end

  @doc """
  Turns a robot right

  ## Examples

  iex> alias ToyRobot.Robot
  ToyRobot.Robot
  iex> robot = %Robot{facing: :north}
  %Robot{facing: :north}
  iex> robot |> Robot.turn_right
  %Robot{facing: :east}
  """
  def turn_right(%Robot{facing: facing} = robot) do
    new_facing = case facing do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end

    %Robot{robot | facing: new_facing}
  end

  defp move_east(%Robot{} = robot, number_of_spaces) do
    %Robot{robot | east: robot.east + number_of_spaces}
  end

  defp move_west(%Robot{} = robot, number_of_spaces) do
    %Robot{robot | east: robot.east - number_of_spaces}
  end

  defp move_north(%Robot{} = robot, number_of_spaces) do
    %Robot{robot | north: robot.north + number_of_spaces}
  end

  defp move_south(%Robot{} = robot, number_of_spaces) do
    %Robot{robot | north: robot.north - number_of_spaces}
  end
end
