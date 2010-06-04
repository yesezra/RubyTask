#!/usr/bin/env ruby

# RubyTask.rb
#
# A simple task manager in Ruby, for learning purposes.

require 'RubyTask/TaskList.rb'

class RubyTask 
  #temporary constant
  FILENAME = "tasklist.txt"
  
  def self.display_menu
    puts "Welcome to Ezra's Ruby Task Manager"
    puts "\tA. Add a new task"
    puts "\tD. Display all tasks"
    puts "\tS. Search for a task by course name"
    puts "\tQ. Quit"
    puts
    print "Please choose an option (A, D, S, Q): "
  end

  def self.process_command(command)
    case command
    when "a" 
      new_task = input_task
      @list.add new_task
    when "d"
      @list.print_all
      puts
    when "s" 
      search
      puts
    when "q"
      break
    else
      puts "Invalid command. Please try again: "
    end    
  end
  
  def self.input_task
    a_task = Task.new
    puts "\nPlease enter the following information."
    print "Course Name: "
    a_task.course_name = gets.chomp
    
    print "Task Description: "
    a_task.task_description = gets.chomp
    
    print "Due Date: "
    a_task.due_date = gets.chomp
    
    a_task
  end
  
  def self.search
    print "\nPlease enter a course name: "
    search_term = gets.chomp
    results = TaskList.new
    
    @list.each do |task|
      results.add task if task.course_name == search_term
    end

    if results.size > 0
      results.print_all
    else 
      puts "No matches found."
    end
  end
  
  def self.run 
    @list = TaskList.new()
    
    @list.load_file(FILENAME)
    
    display_menu
    while command = gets.downcase.chomp do
      process_command command
      display_menu
    end

    @list.save_file(FILENAME)
  end
  
end

###QUESTIONS
# Quit: since case is in helper method process_command, break throws a local jump error. What control structure should I use? I know I could just put the case in the run method, but that would clutter things up more than I would like. 
# Similarly, in what scope and where should I init my list variable? I made it @list (in RubyTask.run) so it would work with the process_command method (and others!), but in C/C++ I would probably instead pass a reference to the list as a parameter. What is the Ruby Way to do this? They're in the same "class" but this really feels like procedural programming so I don't know the best practice.
# How to take a command-line argument for FILENAME using our binary?
# Loading file: I know I should use a CSV gem, but want to try the basic file i/o stuff at least once. How should I be disregarding empty lines and bad data? I have a feeling I need some serious exception handling, yes?
