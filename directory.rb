def input_students
  puts "Enter the names of the students"
  puts "When finished, just hit return twice"
  # Create an empty array
  students = []
  # Get the first student's name
  name = gets.chomp
  # A loop for while the name is not empty
  while !name.empty? do
    # Get the student's favorite hobby
    puts "What is this student's favorite hobby?"
    hobby = gets.chomp
    # Get the student's place of birth
    puts "In which country was this student born?"
    country = gets.chomp
    # Get the student's height
    puts "How tall is this student?"
    height = gets.chomp
    # Get the student's cohort
    puts "Which cohort is the student in? (Default: November)"
    while true do 
      cohort = gets.chomp
      cohort.empty? ? cohort = "november" : cohort
      if cohort =~ /[A-Z]/
        cohort = cohort.downcase!
      end
      if cohort.downcase == "november" || cohort.downcase == "april"
        break
      end
    end
    # Add the student hash to the array
    students << {name: name, cohort: cohort.to_sym, hobby: hobby, country: country, height: height}
    if students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{students.count} students"
    end
    # Get the name of the next student
    puts "What is the name of the next student?"
    name = gets.chomp
  end
  # Return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(25)
  puts "------------".center(25)
end

def print(students)
  students.each_with_index do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)".center(25)
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(25)
end

def print_with_index(students)
  students.each_with_index do |student, index| 
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end
  

def name_begin_with(students, letter)
  beginwithletter = students.select do |student|
    student[:name].downcase.start_with?(letter.downcase) 
  end
  puts "Students with names beginning with the letter '#{letter}'"
  beginwithletter.each do |student|
    puts "#{student[:name]} (#{student[:cohort]})"
  end
end

def name_shorter_than(students, number)
  shorterthan = students.select do |student|
    student[:name].length < number 
  end
  puts "Students with names with less than #{number} characters"
  shorterthan.each do |student|
    puts "#{student[:name]} (#{student[:cohort]})"
  end
end

def new_print(students)
index = 0
  while index < students.count do
    puts "#{index + 1}. #{students[index][:name]} (#{students[index][:cohort]} cohort)"
  index += 1
  end
end

def november_cohort(students)
  students.each do |student|
    if student[:cohort] == :november
      puts student[:name]
    end
  end
end

def grouped_by_cohort(students)
  cohortgroup = {}
  students.each do |student|
    if cohortgroup[student[:cohort]] == nil
      cohortgroup[student[:cohort]] = []
    end
  cohortgroup[student[:cohort]].push(student[:name])
  end

  cohortgroup.each do |cohort, students|
    puts "Students in the #{cohort.capitalize} cohort"
    students.each do |student| puts student end
  end
end

def print_if_not_empty(students)
  if students.count > 0
    students.each_with_index do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)".center(25)
    end
  else nil
  end
end

students = input_students
print_header
print_with_index(students)
print_footer(students)

name_begin_with(students, "a")
name_shorter_than(students, 12)
new_print(students)
november_cohort(students)
grouped_by_cohort(students)
print_if_not_empty(students)