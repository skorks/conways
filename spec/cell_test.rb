require File.expand_path(File.join(File.dirname(__FILE__), 'helpers'))
require 'conways/cell'

this_tests Conways::Cell do
  test("creating a live cell should set its state to a value associated with live") do
    cell = Conways::Cell.live_one
    should_equal(Conways::Cell::LIVE, cell.state)
  end
  test("creating a dead cell should set its state to a value associated with dead") do 
    cell = Conways::Cell.dead_one
    should_equal(Conways::Cell::DEAD, cell.state)
  end
  test("a cell instantiated as live should report live and should not report dead") do
    cell = Conways::Cell.live_one
    should_be_true cell.live?
    should_be_false cell.dead?
  end
  test("state of cell should equal to next state and next state should be nil after moving to next state") do
    cell = Conways::Cell.live_one
    cell.next_state = Conways::Cell::DEAD
    cell.move_to_next_state
    should_equal Conways::Cell::DEAD, cell.state
    should_equal nil, cell.next_state
  end
  test("should get an exception if instantiating cell as neither live nor dead") do
    should_raise { Conways::Cell.new 5 }    
  end
end
