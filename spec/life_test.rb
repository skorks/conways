require File.expand_path(File.join(File.dirname(__FILE__), 'helpers'))
require 'conways'

this_tests Conways::Life do 
  test("a an array that is not two dimensional should be rejected as input") do 
    input = "[1,1,1]"
    should_raise {Conways::Life.new input}
  end
  test ("a two dimensional array that has uneven rows should be rejected as input") do 
    input = "[[0,0,0],[0,1]]"
    should_raise {Conways::Life.new input}
  end
  test("an array that contains more than just zeros and ones should be rejected as input") do 
    input = "[[0,0,0],[2,1]]"
    should_raise {Conways::Life.new input}
  end
  test("a string that had spaces in it but is otherwise valid should NOT be rejected as input") do 
    input = "[[0,0, 0], [0,1, 0], [0,0,0]]"
    should_not_raise {Conways::Life.new input}
  end

  test("a string that is invalid input should be rejected") do 
    input = "["
    should_raise {Conways::Life.new input}
  end
end
