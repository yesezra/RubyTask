require 'spec_helper'

describe Task do
  it "should store three instance variables" do
    today = Date.new
    today_s = today.strftime("%m/%d/%Y")
    task = Task.new("CS162", "Do that same lab again!", today_s)
    task.course_name.should == "CS162"
    task.task_description.should == "Do that same lab again!"
    task.due_date.should == today
  end
  
  it "should initialize even if passed a nil date" do
    task = Task.new(nil, nil, nil)
    
    task.should be_a Task
    task.due_date.should == nil
  end
  
end