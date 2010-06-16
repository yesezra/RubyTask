#!/usr/bin/env ruby

# RubyTask.rb
#
# A simple task manager in Ruby, for learning purposes.

require 'RubyTask/TaskList.rb'

class RubyTask 
  
  ## Menu display methods
  def self.display_menu
    puts "Welcome to Ezra's Ruby Task Manager"
    puts "\tA. Add a new task"
    puts "\tP. Print all tasks"
    puts "\tS. Search for tasks"
    puts "\tD. Delete tasks"
    puts "\tQ. Quit"
    puts
    print "Please choose an option (A, P, S, D, Q): "
  end

  def self.print_search_menu 
    puts "How would you like to search?"
    puts "\tN. Course Name"
    puts "\tT. Task Description"
    puts "\tD. Due Date"
    puts "\tM. Return to Main Menu"
    puts
    print "Please choose an option (N, T, D, M): "
  end
  
  def self.print_search_results(results)
    if results
      results.print_all
    else 
      puts "No matches found."
    end
  end

  ## Program flow methods
  def self.run
    if ARGV != []
      @filename = ARGV[0]
      ARGV.clear
    else
      @filename = "tasklist.txt"
    end

    @list = TaskList.new()
    @list.load_file(@filename)

    display_menu
    catch :quit do
      while command = gets.downcase.chomp do
        process_command command
        display_menu
      end
    end

    @list.save_file(@filename)
  end
  
  def self.process_command(command)
    case command
    when "a" 
      new_task = input_task
      @list.add new_task
    when "p"
      @list.print_all
      puts
    when "s" 
      search
      puts
    when "d"
      delete_task
    when "q"
      throw :quit
    else
      puts "Invalid command. Please try again: "
    end    
  end
  
  def self.search
    print_search_menu

    catch :return do     
      while search_option = gets.downcase.chomp
        case search_option
        when "n" 
          print "Please enter a course name: "
          search_term = gets.chomp
          print_search_results @list.search_by_course(search_term)
        when "t"
          print "Please enter a task description: "
          search_term = gets.chomp
          print_search_results @list.search_by_description(search_term)
        when "d" 
          begin
            print "Please enter a due date (in DD/MM/YYYY format): "
            search_term = Date.parse(gets.chomp)
            print_search_results @list.search_by_date(search_term)
          
          rescue ArgumentError
            puts "Invalid date, please try again. "
            retry
          end
        when "m"
          throw :return
        else
          puts "Invalid option. Please try again: "
        end
        
        puts
        print_search_menu
      end
    end
  end
  
  ## Data I/O methods
  def self.input_task
    a_task = Task.new
    puts "\nPlease enter the following information."
    print "Course Name: "
    a_task.course_name = gets.chomp
    
    print "Task Description: "
    a_task.task_description = gets.chomp
    
    begin
    print "Due Date (in DD/MM/YYYY format): "
    a_task.due_date = gets.chomp          
    rescue ArgumentError
      puts "Invalid date, please try again. "
      retry
    end
    
    a_task
  end
  
  def self.delete_task
    @list.print_all_with_index
    if @list.size > 0
      print "Enter the ID number of the task you wish to delete, or 'C' to cancel: "
      response = gets.downcase.chomp
      return if response == 'c'
      @list.delete(@list[response.to_i - 1]) # Converting from 0-index to 1-index
    end
  end
end
