#!/usr/bin/env ruby

#TaskList.rb
# TaskList class.

require "Task.rb"

class TaskList
  def initialize
    @list = []
  end
  
  def add_task(new_task)
    raise TypeError, "Task argument expected" unless new_task.is_a? Task
    @list.push new_task
  
  end
  
  def search_by_course(course)
  end
  
  def load_file(filename)
  end
  
  def save_file(filename)
  end
end