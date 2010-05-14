!#/usr/bin/env ruby
# Task class
#
class Task
  def initialize(course_name, task_description, due_date)
    @course_name, @task_description, @due_date = course_name, task_description, due_date
  end
  
  attr_accessor :course_name, :task_description, :due_date

  def to_s
    "Course Name: #{@course_name}\nTask Description: #{@task_description}\n#Due Date: {@due_date}"
  end
  
end