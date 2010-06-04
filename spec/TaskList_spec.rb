require 'spec_helper'

describe TaskList do
  it "should each" do
    tl = TaskList.new
    tl.add(Task.new)
    tl.add(Task.new)
    tl.add(Task.new)
    
    tl.each do |task|
      task.should be_a Task
    end
  end
  
  it "should search by course" do
    tl = TaskList.new
    a = Task.new("CS162", "Lab 1", "11/11/1111")
    b = Task.new("CS162", "Lab 1abc", "11/11/1111")
    tl.add(a)
    tl.add(b)
    tl.add(Task.new("CS260", "Lab 88", "11/11/1111"))
    
    tl.search_by_course("CS162").should == [a, b]
  end
  
end