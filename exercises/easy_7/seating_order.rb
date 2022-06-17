# There's a waiting room with N chairs set in single row. Chairs are consecutively numbered from 1 to N. First is closest to the entrance (which is exit as well).

# For some reason people choose a chair in the following way

# Find a place as far from other people as possible
# Find a place as close to exit as possible
# All chairs must be occupied before the first person will be served

# So it looks like this for 10 chairs and 10 patients

# Chairs    1  2  3  4  5  6  7  8  9  10
# Patients  1  7  5  8  3  9  4  6  10  2
# Your task is to find last patient's chair's number.

# 1, 10, 5, 7, 3, 8, 2, 4, 6, 9
# favor the  smallest number but largest gap between the largest number

# Input: number of chairs N, an integer greater than 2.
# Output: a positive integer, the last patient's chair number.

# RSpec.describe 'last_chair' do
#   it 'should return 10 for n = 9' do
#     expect(last_chair(10)).to eq(9)
#   end
# end

# given a number of chairs N
# create a chairs array an array of 1..N
# create an Empty array for order
# push into the array
#   smallest number of the largest difference from existing numbers in the E array
#   remove that number from the chairs array

#given a number of chairs n

# create chairs array of 1..n
# create an empty array for seating_order


# get next_seat
#   loop through existing seats until the second to last element
#     get difference between curre
#     push result into 

# get differences between taken_seats
#   set greatest = []
#       space = 0
#   loop through taken seats (except last seat)
#     if greatest.empty?
#       greatest = [current seat, next seat]
#       space = currentseat - next seat (absolut)
#     elsif space < current seat - next seat (absoulute)
#       greatest = [current seat, next seat]
#       space = currentseat - next seat (absolut)
#     else
#       next
#     end
#     ((greatest[0] + greatest[1]) / 2).floor

    
# get list of differences from existing seat
#   take last number of seating order
#   subtract from available seats
#   push result into array
#   return array.max as maxdifference

# get list of seats where difference from current seat is the highest
#   take current seat, chairs, maxdifference
#   subtract current_seat from chairs
#   if difference == maxdifference
#   push into array
#   return array.min as next_chair

# push next_chair into seating_order
# remove next_chair from chairs

# return the last element of the seating order


# def get_max_difference(next_chair, chairs, seating_order)
#   result = []
#   chairs.each do |chair|
#     result << (next_chair - chair).abs
#   end
#   result.max
# end

# def get_max_distance_seats(next_chair, chairs, max_difference, seating_order)
#   result = []
#   chairs.each do |chair|

#     result << chair if ((next_chair - chair).abs == max_difference)
#   end

#   result.min
# end

def which_seat(seating_order)
  greatest = []
  space = 0
  seating_order = seating_order.sort

  seating_order.each.with_index do |chair, idx|
    break if idx == (seating_order.size - 1)
    if greatest.empty?
      greatest = [chair, seating_order[idx + 1]]
      space = (chair - seating_order[idx + 1]).abs
    elsif space < (chair - seating_order[idx + 1]).abs
      greatest = [chair, seating_order[idx + 1]]
      space = (chair - seating_order[idx + 1]).abs
    else
      next
    end
  end

  (greatest.sum / 2).floor
end

def last_chair(n)

  return n if n <= 1
  chairs = (1..n).to_a
  seating_order = [1, n]
  
  loop do
    next_seat = which_seat(seating_order)

    seating_order << next_seat
    chairs = chairs - seating_order
    break seating_order if chairs.empty?
  end

  seating_order
end

# p which_seat([1,10,5]) # => 1, 5, 10
p last_chair(10)
p last_chair(9)
p last_chair(11)
# def last_chair(n)
#   chairs = (1..n).to_a
#   seating_order = []
#   while !chairs.empty?
#     if seating_order.empty?
#       seating_order << chairs.min
#       chairs.delete(seating_order[-1])
#     else
#       tracker = []
#       chairs.each do |chair|
#         if (chair - seating_order[-1]) < 0
#           tracker << (chair - seating_order[-1]) * -1
#         else
#           tracker << (chair - seating_order[-1])
#         end
#       end
#       p "tracker #{tracker}"
#       tracker = tracker.max
#       check =[]
#       chairs.each do |chair|
#         if chair - seating_order[-1] == tracker
#           check << chair
#         end
#       end
#       seating_order << check.min
#       chairs.delete(seating_order[-1])
#     end
#   end
#   seating_order
# end

# p last_chair(10) #== 9

