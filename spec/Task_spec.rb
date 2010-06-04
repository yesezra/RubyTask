require 'spec_helper'

describe Task do
  it "should store three instance variables" do
    task = Task.new("CS162", "Do that same lab again!", "05/20/2010")
    task.course_name.should == "CS162"
    task.task_description.should == "Do that same lab again!"
    task.due_date.should == "05/20/2010"
  end
end