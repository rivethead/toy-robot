alias ToyRobot.Robot

starting_position = %ToyRobot.Robot{north: 0, east: 0, facing: :north}
{:ok, player} = GenServer.start(ToyRobot.Game.Player, starting_position)
GenServer.call(player, :report)

GenServer.cast(player, :move)
GenServer.cast(player, :move)
GenServer.cast(player, :move)

GenServer.call(player, :report)
