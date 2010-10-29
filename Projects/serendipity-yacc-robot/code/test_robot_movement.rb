require 'test/unit'
require 'robot_movement.rb'
class TestMovement < Test::Unit::TestCase

  def setup
    @a_10_by_10_board = RobotMovement::Board.new(9, 9)
    @initial_robot = RobotMovement::Robot.new(0, 0, :s)
  end


  def test_basic_functions
    assert @a_10_by_10_board.eql? RobotMovement::Board.new(9, 9)
    assert @initial_robot.eql? RobotMovement::Robot.new(0, 0, :s)

  end

  def test_commands
    assert_not_nil RobotMovement.parser.parse('hello robot')
    assert_nil RobotMovement.parser.parse('hello chomsky')
    assert_nil RobotMovement.parser.parse('WRONG INPUT!')
    #     (check-equal? (process-mech (open-input-string "20 40\n2 0 S\nT 0 2\nMMLMLM"))
    #               (make-mech 1 1 #\N))
    #  
    #     (check-equal? (process-mech (open-input-string "3 3\n1 1 N\nRMLMLMMLMM"))
    #               (make-mech 0 0 #\S))body
  end



end
