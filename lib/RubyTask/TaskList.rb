#!/usr/bin/env ruby

#TaskList.rb
# TaskList class.

require 'RubyTask/Task.rb'

class TaskList
  include Enumerable
  
  def initialize
    @list = []
  end
  
  def each
    @list.each {|task| yield task}
  end
  
  def add(*new_tasks)
    new_tasks.each do |task|
      raise TypeError, "Task argument expected" unless task.is_a? Task
    @list.push task
    end
  end

  def delete(a_task) 
    @list.delete a_task
  end

  def search_by_course(course)
    results = TaskList.new

    @list.each do |task|
      results.add(task) if task.course_name.downcase.include? course.downcase
    end

    results.empty? ? nil : results
  end
  
  def search_by_description(description)
    results = TaskList.new
    
    @list.each do |task|
      results.add(task) if task.task_description.downcase.include? description.downcase
    end
    
    results.empty? ? nil : results
  end

  def search_by_date(date)
    results = TaskList.new
    
    @list.each do |task|
      results.add(task) if task.due_date == date
    end
    
    results.empty? ? nil : results
  end

  def load_file(filename)
    begin
      File.open(filename, "r") do |data|
        while line = data.gets do
          break if line == "\n"
          fields = line.split(";") 
          raise "Bad file format: line #{data.lineno} does not contain three fields. " if fields.length != 3
          add Task.new(*fields)
        end
      end
      
    rescue Exception => e
      puts e
      exit
    end
  end
  
  def save_file(filename)
    begin
      File.open(filename, "w") do |file| 
        each do |task|
          file.puts "#{task.course_name};#{task.task_description};#{task.due_date.strftime("%m/%d/%Y")}"
        end
      end
    
    rescue Exception => e
      puts e
      exit
    end
  end
  
  def print_all
    if @list.size > 0  
      printf(Task::TABULAR_FORMAT, 'Course Name', 'Task Description', 'Due Date')
      puts
      each {|task| puts task.tabular}
    else
      puts "List is empty."
    end
  end
  
  def print_all_with_index
    if @list.size > 0  
      printf("%-3s #{Task::TABULAR_FORMAT}", 'ID', 'Course Name', 'Task Description', 'Due Date')
      puts
      each_with_index do |task, index|
        printf("%-4i", index + 1) # convert 0-index to 1-index
        puts task.tabular
      end
    else
      puts "List is empty."
    end    
  end
  
  def size 
    @list.length
  end
  
  def empty?
    size == 0 ? true : false
  end
    
  def [](index)
    @list[index]
  end
  
  alias length size
end