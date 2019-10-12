defmodule ToyRobot.CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "provides usage instructions if no arguments specified" do
    output =
      capture_io(fn ->
        ToyRobot.CLI.main([])
      end)

    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "privdes usage instructions if too many arguments specified" do
    output =
      capture_io(fn ->
        ToyRobot.CLI.main(["commands.txt", "commands2.txt"])
      end)

    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "shows an error mesage if the file does not exist" do
    output =
      capture_io(fn ->
        ToyRobot.CLI.main(["i-don't-exist.txt"])
      end)

    assert output |> String.trim() == "The file i-don't-exist.txt does not exist"
  end

  test "handles commands and reports successfully" do
    commands_path = Path.expand("test/fixtures/commands.txt", File.cwd!())

    output = capture_io fn ->
      ToyRobot.CLI.main([commands_path])
    end

    expected_output = """
    The robot is at (0, 4) and is facing NORTH
    """

    assert output |> String.trim == expected_output |> String.trim
  end
end
