def input_students
  puts "Enter the names of the students"
  puts "When finished, just hit return twice"
  # Create an empty array
  students = []
  # Get the first student's name
  name = gets.chomp
  # A loop for while the name is not empty
  while !name.empty? do
    # Add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # Get the name of the next student
    name = gets.chomp
  end
  # Return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "------------"
end

def print(students)
  students.each do |student| 
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)

