defmodule ToyRobot.CommandInterpreter do
  @doc """
  Interprets commands from a commands list, in preparation for running them.

  ## Examples

  ### Simple commands

  iex> alias ToyRobot.CommandInterpreter
  ToyRobot.CommandInterpreter
  iex> commands = ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "REPORT"]
  ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "REPORT"]
  iex> commands |> CommandInterpreter.interpret()
  [
  {:place, %{north: 2, east: 1, facing: :north}},
  {:move, 1},
  :turn_left,
  :turn_right,
  :report,
  ]

  ### MOVE command with number of spaces specified

  iex> alias ToyRobot.CommandInterpreter
  ToyRobot.CommandInterpreter
  iex> commands = ["PLACE 1,2,NORTH", "MOVE 2", "LEFT", "RIGHT", "REPORT"]
  ["PLACE 1,2,NORTH", "MOVE 2", "LEFT", "RIGHT", "REPORT"]
  iex> commands |> CommandInterpreter.interpret()
  [
  {:place, %{north: 2, east: 1, facing: :north}},
  {:move, 2},
  :turn_left,
  :turn_right,
  :report,
  ]

  """
  def interpret(commands) do
    commands |> Enum.map(&do_interpret/1)
  end

  defp do_interpret("PLACE " <> _rest = command) do
    format = ~r/\APLACE (\d+),(\d+),(NORTH|EAST|SOUTH|WEST)\z/

    case Regex.run(format, command) do
      [_command, east, north, facing] ->
        to_int = &String.to_integer/1

        {:place,
         %{
           east: to_int.(east),
           north: to_int.(north),
           facing: facing |> String.downcase() |> String.to_atom()
         }}

      nil ->
        {:invalid, command}
    end
  end

  defp do_interpret("MOVE " <> _rest = command) do
    format = ~r/\AMOVE (\d+)\z/

    case Regex.run(format, command) do
      [_command, number_of_spaces] ->
        to_int = &String.to_integer/1

        {:move, to_int.(number_of_spaces)}

      nil ->
        {:invalid, command}
    end
  end

  defp do_interpret("MOVE"), do: {:move, 1}

  defp do_interpret("LEFT"), do: :turn_left
  defp do_interpret("RIGHT"), do: :turn_right
  defp do_interpret("REPORT"), do: :report
  defp do_interpret(invalid), do: {:invalid, invalid}
end
