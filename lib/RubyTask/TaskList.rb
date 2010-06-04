#!/usr/bin/env ruby

#TaskList.rb
# TaskList class.

require 'RubyTask/Task.rb'


class TaskList
  def initialize
    @list = []
  end
  
  def each
    @list.each {|task| yield task}
  end
  
  def add(new_task)
    raise TypeError, "Task argument expected" unless new_task.is_a? Task
    @list.push new_task
  end
  
  def search_by_course(course)
    results = @list.select {|task| task.course_name == course}
    results.empty? ? nil : results
  end
  
  def load_file(filename)
    File.open(filename, "r") do |data|
      while line = data.gets do
        break if line == "\n"
        course_name, task_description, due_date = line.split(";") 
        add Task.new(course_name, task_description, due_date)
      end
    end
  end
  
  def save_file(filename)
    File.open(filename, "w") do |file| 
      each do |task|
        file.puts "#{task.course_name};#{task.task_description};#{task.due_date}"
      end
    end
  end
  
  def print_all
    if @list.size > 0  
      printf(Task::TABULAR_FORMAT, 'Course Name', 'Task Description', 'Due Date')
      puts
      each {|task| puts task.tabular}
    end
  end
  
  def size 
    @list.length
  end
  
  alias length size
end