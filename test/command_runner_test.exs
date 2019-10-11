defmodule ToyRobot.CommandRunnerTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias ToyRobot.{CommandRunner, Simulation}

  test "handles a valid place command" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{east: 1, north: 2, facing: :north}}])

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :north
  end

  test "handles an invalid place command" do
    simulation = CommandRunner.run([{:place, %{east: 10, north: 10, facing: :north}}])

    assert simulation == nil
  end

  test "ignores command until a valid placement" do
    commands = [{:move, 1}, {:place, %{east: 1, north: 2, facing: :north}}]
    %Simulation{robot: robot} = commands |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :north
  end

  test "handles a place + move command" do
    commands = [{:place, %{east: 1, north: 2, facing: :north}}, {:move, 1}]
    %Simulation{robot: robot} = commands |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 3
    assert robot.facing == :north
  end

  test "handles a place + move command with number of spaces specified" do
    commands = [{:place, %{east: 1, north: 2, facing: :north}}, {:move, 2}]
    %Simulation{robot: robot} = commands |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 4
    assert robot.facing == :north
  end

  test "handles a place + invalid move command" do
    commands = [{:place, %{east: 1, north: 4, facing: :north}}, {:move, 1}]
    %Simulation{robot: robot} = commands |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 4
    assert robot.facing == :north
  end

  test "handle a place + turn_left command" do
    commands = [{:place, %{east: 1, north: 2, facing: :north}}, :turn_left]
    %Simulation{robot: robot} = commands |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :west
  end

  test "handle a place + turn_right command" do
    commands = [{:place, %{east: 1, north: 2, facing: :north}}, :turn_right]
    %Simulation{robot: robot} = commands |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :east
  end

  test "handles a place + report command" do
    commands = [{:place, %{east: 1, north: 2, facing: :north}}, :report]

    output =
      capture_io(fn ->
        CommandRunner.run(commands)
      end)

    assert output |> String.trim() == "The robot is at (1, 2) and is facing NORTH"
  end

  test "handle a place + invalid command" do
    commands = [{:place, %{east: 1, north: 2, facing: :north}}, {:invalid, "EXTERMINATE"}]
    %Simulation{robot: robot} = commands |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :north
  end

  test "robot cannot move beyond the north boundary" do
    %Simulation{robot: robot} = [{:place, %{north: 4, east: 0, facing: :north}}]
    |> CommandRunner.run

    assert robot.north == 4
  end

  test "robot cannot move beyond the east boundary" do
    %Simulation{robot: robot} = [{:place, %{east: 4, north: 0, facing: :east}}]
    |> CommandRunner.run

    assert robot.east == 4
  end

  test "robot cannot move beyond the south boundary" do
    %Simulation{robot: robot} = [{:place, %{north: 0, east: 0, facing: :south}}]
    |> CommandRunner.run

    assert robot.north == 0
  end

  test "robot cannot move beyond the west boundary" do
    %Simulation{robot: robot} = [{:place, %{east: 0, north: 0, facing: :west}}]
    |> CommandRunner.run

    assert robot.east == 0
  end

end
