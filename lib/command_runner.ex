defmodule ToyRobot.CommandRunner do
  alias ToyRobot.{Simulation, Table}

  def run([{:place, placement} | rest]) do
    table = %Table{north_boundary: 4, east_boundary: 4}

    returned_simulation = case Simulation.place(table, placement) do
      {:ok, simulation} -> run(rest, simulation)
      {:error, :invalid_placement} -> run(rest)
    end

    returned_simulation
  end

  def run([_command | rest]), do: run(rest)
  def run([]), do: nil

  def run([{:move, number_of_places} | rest], simulation) do

    new_simulation = case simulation |> Simulation.move(number_of_places) do
      {:ok, simulation} -> simulation
      {:error, :at_table_boundary} -> simulation
    end

    run(rest, new_simulation)
  end

  def run([:turn_left | rest], simulation) do
    {:ok, simulation} = simulation |> Simulation.turn_left
    run(rest, simulation)
  end

  def run([:turn_right | rest], simulation) do
    {:ok, simulation} = simulation |> Simulation.turn_right
    run(rest, simulation)
  end

  def run([:report | rest], simulation) do
    %{east: east, north: north, facing: facing} = Simulation.report(simulation)

    facing = facing |> Atom.to_string |> String.upcase

    IO.puts "The robot is at (#{east}, #{north}) and is facing #{facing}"

    run(rest, simulation)
  end

  def run([{:invalid, _} | rest], simulation), do: run(rest, simulation)
  def run([], simulation), do: simulation
end
