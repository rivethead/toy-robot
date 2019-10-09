defmodule ToyRobot.Robot do
  alias ToyRobot.Robot

  defstruct north: 0, east: 0, facing: :north

  @doc """
  Moves the robot forward one space in the direction it is facing

  ## Examples
    iex> alias ToyRobot.Robot
    ToyRobot.Robot
    iex> robot = %Robot{north: 0, facing: :north}
    %Robot{north: 0, east: 0, facing: :north}
    iex> robot |> Robot.move
    %Robot{north: 1, east: 0, facing: :north}
  """
  def move(%Robot{facing: facing} = robot) do
    case facing do
      :north -> robot |> move_north
      :south -> robot |> move_south
      :east -> robot |> move_east
      :west -> robot |> move_west
    end
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

  defp move_east(%Robot{} = robot) do
    %Robot{robot | east: robot.east + 1}
  end

  defp move_west(%Robot{} = robot) do
    %Robot{robot | east: robot.east - 1}
  end

  defp move_north(%Robot{} = robot) do
    %Robot{robot | north: robot.north + 1}
  end

  defp move_south(%Robot{} = robot) do
    %Robot{robot | north: robot.north - 1}
  end
end
