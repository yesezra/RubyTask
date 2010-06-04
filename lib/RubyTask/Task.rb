!#/usr/bin/env ruby
# Task class
#
class Task
  TABULAR_FORMAT = '%-12s %-35s %-10s'
  
  def initialize(course_name=nil, task_description=nil, due_date=nil)
    @course_name, @task_description, @due_date = course_name, task_description, due_date
  end
  
  attr_accessor :course_name, :task_description, :due_date
  
  def to_s
    "Course Name: #{@course_name}\nTask Description: #{@task_description}\n#Due Date: #{@due_date}"
  end
  
  def one_line
    "Course Name: #{@course_name}\tTask Description: #{@task_description}\tDue Date: #{@due_date}"
  end
  
  def tabular
    sprintf(TABULAR_FORMAT, @course_name, @task_description, @due_date)
  end
end