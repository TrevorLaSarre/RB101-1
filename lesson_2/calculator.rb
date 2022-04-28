require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = 'en'

# set up methods
def prompt(text)
  message = messages(text, LANGUAGE)
  puts "=> #{message}"
end

# Test if number is integer
def integer?(number)
  number.to_i.to_s == number
end

# Test if number is float
def float?(number)
  number.to_f.to_s == number || number.to_i.to_s + '.' == number
end

# Test if input is a number
def number?(number)
  integer?(number) || float?(number)
end

# retrieve message is specified language from yaml file
def messages(text, language = 'en')
  MESSAGES[language][text]
end

# Asks for input number
def get_number
  loop do
    prompt('get_number')
    num = gets.chomp

    if number?(num)
      if float?(num)
        break num.to_f
      else
        break num.to_i
      end
    else
      prompt('not_number')
    end
  end
end

def get_operation
  loop do
    prompt('operation')
    operation = gets.chomp

    if %w(1 2 3 4).include?(operation)
      return operation
    else
      prompt('invalid_operation')
    end
  end
end

def get_result(operation, num1, num2)
  case operation
    when '1'
      result, operator = [num1 + num2, '+']
    when '2'
      result, operator = [num1 - num2, '-']
    when '3'
      result, operator = [num1 * num2, 'x']
    when '4'
      result, operator = [(num1.to_f / num2).round(2), '/']
    else
      get_result(operation,num1,num2)
  end
end

def dramatic_effect
  print "Calculating"
  3.times do
    print "."
    sleep(0.5)
  end
  puts "\n"
end

def play_again()
  prompt('again')
  recalculate = gets.chomp.upcase
end

loop do
  num1 = get_number()
  num2 = get_number()
  operation = get_operation
  result, operator = get_result(operation,num1,num2)
  dramatic_effect
  puts "#{num1} #{operator} #{num2} = #{result}"

  break unless play_again().start_with?('Y')

end








# # start of program execution
# loop do
#   # verify number 1 is a number
#   num1 = ''
#   loop do
#     prompt('get_number')
#     num1 = gets.chomp

#     if number?(num1)
#       break
#     else
#       prompt('not_number')
#     end
#   end

#   # verify number 2 is a number
#   num2 = ''
#   loop do
#     prompt('get_number')
#     num2 = gets.chomp

#     if number?(num2)
#       break
#     else
#       prompt('not_number')
#     end
#   end

#   #  convert numbers to interger or float
#   if float?(num1) || float?(num2)
#     num1 = num1.to_f
#     num2 = num2.to_f
#   else
#     num1 = num1.to_i
#     num2 = num2.to_i
#   end

#   # get operation and run
#   loop do
#     prompt('operation')
#     operation = gets.chomp

#     case operation
#     when '1'
#       result = num1 + num2
#       operator = '+'
#     when '2'
#       result = num1 - num2
#       operator = '-'
#     when '3'
#       result = num1 * num2
#       operator = 'x'
#     when '4'
#       result = (num1.to_f / num2).round(2)
#       operator = '/'
#     else
#       prompt('invalid_operation')
#       next
#     end

#     puts "#{num1} #{operator} #{num2} = #{result}"
#     break
#   end

#   # ask if user wants to go again
#   prompt('again')
#   recalculate = gets.chomp
#   if recalculate.upcase.start_with?('Y')
#     next
#   else
#     break
#   end
# end

