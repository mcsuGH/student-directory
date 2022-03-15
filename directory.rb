@students = []

def input_students
  puts "Enter the names of the students"
  puts "When finished, just hit return twice"
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
      cohort = cohort.capitalize!
      if cohort == "November" || cohort == "April"
        break
      end
    end
    # Add the student hash to the array
    @students << {name: name, cohort: cohort.to_sym, hobby: hobby, country: country, height: height}
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    # Get the name of the next student
    puts "What is the name of the next student?"
    name = gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy".center(25)
  puts "------------".center(25)
end

def print_students_list
  @students.each_with_index do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)".center(25)
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(25)
end

def print_with_index
  @students.each_with_index do |student, index| 
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end
  

def name_begin_with(letter)
  beginwithletter = @students.select do |student|
    student[:name].downcase.start_with?(letter.downcase) 
  end
  puts "Students with names beginning with the letter '#{letter}'"
  beginwithletter.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def name_shorter_than(number)
  shorterthan = @students.select do |student|
    student[:name].length < number 
  end
  puts "Students with names with less than #{number} characters"
  shorterthan.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def new_print
index = 0
  while index < @students.count do
    puts "#{index + 1}. #{@students[index][:name]} (#{@students[index][:cohort]} cohort)"
  index += 1
  end
end

def single_cohort(cohort)
  if cohort =~ /[A-Z]/
    cohort = cohort.downcase!
  end
  cohort = cohort.capitalize!
  puts "Students in the #{cohort} cohort"
  @students.each do |student|
    if student[:cohort] == cohort.to_sym
      puts student[:name]
    end
  end
end

def grouped_by_cohort
  cohortgroup = {}
  @students.each do |student|
    if cohortgroup[student[:cohort]] == nil
      cohortgroup[student[:cohort]] = []
    end
  cohortgroup[student[:cohort]].push(student[:name])
  end

  cohortgroup.each do |cohort, students|
    puts "Students in the #{cohort} cohort"
    students.each do |student| puts student end
  end
end

def print_if_not_empty
  if @students.count > 0
    puts "The students of Villains Academy".center(25)
    puts "------------".center(25)
    @students.each_with_index do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)".center(25)
    end
    puts "Overall, we have #{@students.count} great students".center(25)
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "9"
    exit 
  else
    puts "I don't know what you meant, try again"
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

interactive_menu