#!/usr/bin/env ruby
load("#{File.dirname(__FILE__)}/../load_lib.rb")
load("#{File.dirname(__FILE__)}/pretty_printer.rb")

include PrettyPrinter

def get_input
  answer = ''
  while true
    char = STDIN.getc
    answer += char.chr
    break if char == "\n"
  end

  answer
end

def start_console
  while true
    STDOUT.write('soft 0.1> ')
    input = get_input
    shut_down if input == "exit\n"

    begin
      compile input
    rescue Exception => e
      print_warning("Parsing error: #{e.message} \n")
    end
  end
  reset_terminal
end

def compile(input)
  tokens = Soft::Scanner.tokenize input
  print_in :yellow, " => #{tokens}\n"
  print_info " => #{Soft::Parser.new.to_statements tokens}\n"
end

def shut_down
  print_warning "\nShutting down gracefully..."
  sleep 1
  exit
end

def shut_down_with_error(err)
  print_warning "\nShutting down because of following error\n#{err}"
  sleep 1
  exit
end

def reset_terminal
  system 'stty sane'
end

Signal.trap("INT") {
  reset_terminal
  shut_down
}

start_console
