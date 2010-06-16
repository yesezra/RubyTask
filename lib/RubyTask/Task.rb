!#/usr/bin/env ruby
# Task class
#

require "date"

class Task  
  TABULAR_FORMAT = '%-12s %-35s %-10s'
  
  def initialize(course_name=nil, task_description=nil, due_date=nil)
    @course_name, @task_description = course_name, task_description
    
    self.due_date = due_date if due_date 
  end
  
  attr_accessor :course_name, :task_description
  attr_reader :due_date
    
  def due_date=(datestring)
    @due_date = Date.parse(datestring)
  end
  
  def to_s
    "Course Name: #{@course_name}\nTask Description: #{@task_description}\nDue Date: #{formatted_date}"
  end
  
  def one_line
    "Course Name: #{@course_name}\tTask Description: #{@task_description}\tDue Date: #{formatted_date}"
  end
  
  def tabular
    sprintf(TABULAR_FORMAT, @course_name, @task_description, formatted_date)
  end
  
  private
  def formatted_date 
    @due_date.strftime("%m/%d/%Y") if @due_date
  end
end