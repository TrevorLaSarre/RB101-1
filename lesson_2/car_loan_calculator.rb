=begin
Problem
Create a loan calculator

using 3 pieces of information:  loan amount
                                Annual Percentage Rate (APR)
                                loan duration

calculate: the monthly interest rate
           loan duration in months
           and monthly payment


annual percentage rate needs to be converted to monthly (((APR/100)/12) * loan amount)
  = a monthly interest rate is an amount of money not a percentage
use months for loan duration (1 year = 12 months)
convert year to months (year * 12 = duration_months)

loan_calculator(loan_amount, apr, duration_months)


rules

implicit
 loan amount, apr, and loan duration can't be less than zero

E




D
input: float: loan amount, float: apr, integer: years

middle:

output: float: monthly payments


A

get Loan amount
    Annual Percentage Rate
    Loan duration

convert annual percentage rate to monthly interest rate (SP)
  - (APR/100)/12 * loan_amount
convert loan duration from years to months
  - duration_months * 12
calculate montly payment


GET loan amount
  - verify valid
GET Annual Percentage Rate
  - verify valid
GET loan duration in years
  - verify valid

SET monthly interest rate using annual percentage rate
SET loan duration in months from years
SET monthly payment amount

PRINT monthly payment amount (round to 2 decimal points)
=end



def prompt(message)
  puts "=> #{message}"
end

# method for verifying number input is valid
def is_number?(input)
  input.to_f.to_s == input || input.to_i.to_s == input || input.to_i.to_s + '.' == input
end


def get_loan_amount
  loop do
    print "Enter your loan amount: $"
    loan_amount = gets.chomp

    if is_number?(loan_amount) && loan_amount > 0
      return loan_amount
    else
      prompt "Not a valid amount"
    end
  end
end

def get_apr
  loop do
    prompt "What is your APR? (10% written as 10. 2.5% as 2.5)"
    apr = gets.chomp
    next if apr.empty?

    if is_number(apr) && apr.to_f >= 0 
      break apr.to_f
    else
      prompt "Invalid entry!"
    end
  end

def get_duration
  loop do
    prompt "How long is your loan duration (in years)?"
    duration = gets.chomp
    next if duration.empty?

    if is_number(duration) && duration.to_f >= 0
      break duration.to_f
    end
  end
end

def apr_to_monthly(apr)
  (apr/100)/12
end

def years_to_months(duration)
  duration * 12
end

def monthly_payment_amt(loan_amount, monthly_interest_rate, duration_months)
  loan_amount * 
  (monthly_interest_rate / 
  (1 - (1 + monthly_interest_rate) **(-duration_months)))
end

def again?
  prompt "Want to calculate another morgage? Y/N"
  again = gets.chomp
  again? if again.empty?

  


# Start of program
loop do
  prompt "Welcome to Loan Calculator!"
  prompt "---------------------------"

  # Validating loop for loan amount and conversion to float

  loan_amount = ''
  loop do
    
    

    if is_number?(loan_amount) && loan_amount.empty? == false && loan_amount.to_f > 0
      loan_amount = loan_amount.to_f.round(2)
      break
    else
      prompt "not a valid number"
    end
  end

  # Validating loop for apr and conversion to float
  apr = ''
  loop do
    prompt "What is your APR? (ex 10% as 10 and 2.5% as 2.5)"
    apr = gets.chomp

    if is_number?(apr) && apr.to_f >= 0 && apr.empty? == false
      apr = apr.to_f
      break
    else
      prompt "not a valid percentage."
    end
  end

  # Validating loop for laon duration and conversion to float(to account for half years)
  duration = ''
  loop do
    prompt "What is the length of the loan in years."
    duration = gets.chomp

    if is_number?(duration) && duration.empty? == false && duration.to_f > 0
      duration = duration.to_f
      break
    else
      prompt "not a valid number"
    end
  end

  # convert duration from years to number of months
  duration_months = duration * 12

  #convert Annaul Percentage to Monthly Percentage and decimal value for percentage
  monthly_interest_rate = (apr.to_f / 100) / 12

  # calculate monthly payment
  monthly_payment = loan_amount * 
                      (monthly_interest_rate / 
                      (1 - (1 + monthly_interest_rate) **(-duration_months)))

  prompt "You're monthly payment is #{format($%.2f, monthly_payment)}"

  # Prompt to re-run or exit program
  prompt "Would you like to calculate another payment? Y/N"
  again = gets.chomp

  break unless again.downcase.start_with?('y')
end

# Exit message
prompt "Thank you for using the Loan Calculator"
prompt "Have a great day!"