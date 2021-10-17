require_relative 'arm'
require_relative 'robot'

def test
  poker = Arm.new(666, :poker)
  slash = Arm.new(333, :slasher)
  grab = Arm.new(111, :grabber)
  robot = Robot.new("Terminator")
  robot.add_arms(poker, slash, grab, poker, slash, grab, poker, slash, grab, poker)
  puts robot.name
  robot.introduce

  other_robot = Robot.new("Predator")
  other_robot.add_arms(poker, poker, poker)
  other_robot.add_arms([poker, poker, poker])
  other_robot.introduce

  if robot > other_robot
    puts 'first is better'
  else
    puts 'second is better'
  end

  [robot, other_robot].sort
  [robot, other_robot].max

  robot.encrypt('a1b2c3 YoLO thIS _is ^~ˇ^˘° kinda cool')
end

test
