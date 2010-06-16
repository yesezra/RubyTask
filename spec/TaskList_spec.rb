require 'spec_helper'

describe TaskList do
  before(:each) do
    @tl = TaskList.new
  end
  
  it "should add a new task" do
    a = Task.new
    @tl.add(a)

    @tl[-1].should == a
  end
  
  it "should add multiple new tasks" do
    a = Task.new
    b = Task.new
    c = Task.new
    @tl.add(a, b, c)
    
    @tl.should include(a, b, c)
  end
  
  it "should return correctly indexed tasks" do
    a = Task.new
    b = Task.new
    @tl.add(a, b)
    
    @tl[0].should == a
    @tl[1].should == b
  end

  it "should delete tasks" do
    a = Task.new
    @tl.add(a)
    
    @tl.delete(a)
    @tl.should_not include(a)
  end
  
  it "should not delete the wrong task" do
    a = Task.new
    b = Task.new
    @tl.add(a, b)
    
    @tl.delete(a)
    @tl.should include(b)
  end

  it "should each" do
    one, two = Task.new, Task.new
    @tl.add(one, two)

    one.should_receive(:to_s)
    two.should_receive(:to_s)
    
    @tl.each do |task|
      task.to_s
    end
  end
  
  it "should search by course" do
    a = Task.new("CS162", "Lab 1", "11/11/1111")
    b = Task.new("CS162", "Lab 1abc", "11/11/1111")
    c = Task.new("CS260", "Lab 88", "11/11/1111")
    @tl.add(a, b, c)
    
    @tl.search_by_course("CS162").should include(a, b)
    @tl.search_by_course("CS162").should_not include(c)
  end
  
  it "should search by description" do
    a = Task.new("CS162", "Lab 1", "01/02/2010")
    b = Task.new("CS162", "Lab 2", "02/03/2011")
    c = Task.new("CS260", "Lab 88", "09/10/2025")
    @tl.add(a, b, c)
    
    @tl.search_by_description("Lab 1").should include(a)
    @tl.search_by_description("Lab 1").should_not include(b, c)
    @tl.search_by_description("Lab").should include(a, b, c)
  end
  
  it "should search by date" do
    a = Task.new("CS162", "Lab 1", "01/02/2010")
    b = Task.new("CS162", "Lab 2", "02/03/2010")
    c = Task.new("CS260", "Lab 88", "09/10/2025")
    @tl.add(a, b, c)
    
    @tl.search_by_date(Date.parse("01/02/2010")).should include(a)
    @tl.search_by_date(Date.parse("01/02/2010")).should_not include(b, c)    
  end
  
  it "should save a properly formatted file" do
    a = Task.new("CS162", "Lab 1", "01/02/2010")
    b = Task.new("CS162", "Lab 1abc", "02/03/2011")
    c = Task.new("CS260", "Lab 88", "09/10/2025")
    goodlist = "CS162;Lab 1;01/02/2010\nCS162;Lab 1abc;02/03/2011\nCS260;Lab 88;09/10/2025\n"
    @tl.add(a, b, c)

    FakeFS do          
      @tl.save_file("tasklist.txt")

      File.read("tasklist.txt").should == goodlist
    end
  end
  
end