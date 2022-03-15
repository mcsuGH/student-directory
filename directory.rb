@students = []

def input_students
  puts "Enter the names of the students"
  puts "When finished, just hit return twice"
  # Get the first student's name
  name = STDIN.gets.chomp
  # A loop for while the name is not empty
  while !name.empty? do
    # Get the student's favorite hobby
    puts "What is this student's favorite hobby?"
    hobby = STDIN.gets.chomp
    # Get the student's place of birth
    puts "In which country was this student born?"
    country = STDIN.gets.chomp
    # Get the student's height
    puts "How tall is this student?"
    height = STDIN.gets.chomp
    # Get the student's cohort
    puts "Which cohort is the student in? (Default: November)"
    while true do 
      cohort = STDIN.gets.chomp
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
    add_student(name, cohort, hobby, country, height)
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    # Get the name of the next student
    puts "What is the name of the next student?"
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy".center(25)
  puts "------------".center(25)
end

def print_students_list
  @students.each do |student|
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
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load  the list"
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
    puts "Enter the file which you wish to save as (Default: students.csv)"
    filesave = STDIN.gets.chomp
    filesave.empty? ? save_students : save_students(filesave)
  when "4"
    puts "Enter the file which you wish to load from (Default: students.csv)"
    fileload = STDIN.gets.chomp
    fileload.empty? ? load_students : load_students(fileload)
  when "9"
    exit 
  else
    puts "I don't know what you meant, try again"
  end
end

def save_students(filename = "students.csv")
  file = File.open(filename, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobby], student[:country], student[:height]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "You have saved the list of students into #{filename}"
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, hobby, country, height = line.chomp.split(',')
    add_student(name, cohort, hobby, country, height)
  end
  file.close
  puts "You have loaded the list of students from #{filename}"
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
      puts "Loaded #{@students.count} from students.csv by default"
  elsif File.exists?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} does not exist"
    exit
  end
end

def add_student(name, cohort, hobby, country, height)
  @students << {name: name, cohort: cohort.to_sym, hobby: hobby, country: country, height: height}
end


try_load_students
interactive_menu