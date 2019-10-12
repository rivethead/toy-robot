defmodule ToyRobot.Game.Player do
  use GenServer
  alias ToyRobot.Robot

  def start(position) do
    GenServer.start(__MODULE__, position)
  end

  def report(player) do
    GenServer.call(player, :report)
  end

  def move(player) do
    GenServer.cast(player, :move)
  end

  def init(robot) do
    {:ok, robot}
  end

  def handle_cast(:move, robot) do
    {:noreply, robot |> Robot.move()}
  end

  def handle_call(:report, _from, robot) do
    {:reply, robot, robot}
  end
end
