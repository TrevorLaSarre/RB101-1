
def integer?(number)
  number.to_i.to_s == number
end

def float?(number)
  number.to_f.to_s == number
end

def number?(number)
  integer?(number) || float?(number)
end

message_configuration = { get_number: "Enter a number", 
                          not_number: "Not a valid number",
                          operation: "What operation would you like to perform?",
                          invalid_operation: "Not a valid operation",
                          again: "Whant to go again? Y/N"
                        }

loop do
  
  # verify number 1 is a number
  num1 = ''
  loop do 

    puts message_configuration[:get_number]
    num1 = gets.chomp

    if number?(num1)
      break
    else
      puts message_configuration[:not_number]
    end
  
  end

  # verify number 2 is a number
  num2 = ''
  loop do

    puts message_configuration[:get_number]
    num2 = gets.chomp

    if number?(num2)
      break
    else
      puts message_configuration[:not_number]
    end
  
  end

  #  convert numbers to interger or float
  if float?(num1) || float?(num2)
    num1 = num1.to_f
    num2 = num2.to_f
  else
    num1 = num1.to_i
    num2 = num2.to_i
  end

  # get operation and run
  loop do
    puts message_configuration[:operation]
    operation = gets.chomp
    result = 0
    operator = ''

    case operation
    when 'add'
      result =  num1 + num2
      operator = '+'
    when 'subtract'
      result =  num1 - num2
      operator = '-'
    when 'multiply'
      result =  num1 * num2
      operator = 'x'
    when 'divide'
      result =  num1.to_f / num2
      operator = '/'
    else
      puts message_configuration[:invalid_operation]
      next
    end

    puts "#{num1} #{operator} #{num2} = #{result}"
    break
  end

  # ask if user wants to go again
  puts message_configuration[:again]
  recalculate = gets.chomp
  if recalculate.upcase.start_with?('Y')
    next
  else
    break
  end
end
      