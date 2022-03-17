@students = []
require 'csv'

def input_students
  puts "Enter the names of the students"
  puts "When finished, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "What is this student's favorite hobby?"
    hobby = STDIN.gets.chomp
    puts "In which country was this student born?"
    country = STDIN.gets.chomp
    puts "How tall is this student?"
    height = STDIN.gets.chomp
    puts "Which cohort is the student in? (Default: November)"
    while true do 
      cohort = STDIN.gets.chomp
      cohort.empty? ? cohort = "november" : cohort
      capitalise(cohort)
      if cohort == "November" || cohort == "April"
        break
      end
    end
    add_student(name, cohort, hobby, country, height)
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    puts "What is the name of the next student?"
    name = STDIN.gets.chomp
  end
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

def new_print_using_loop
index = 0
  while index < @students.count do
    puts "#{index + 1}. #{@students[index][:name]} (#{@students[index][:cohort]} cohort)"
  index += 1
  end
end

def single_cohort(cohort)
  capitalise(cohort)
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
    @students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)".center(25)
    end
    puts "Overall, we have #{@students.count} great students".center(25)
  else puts "There are currently no students."
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
  puts "3. Delete student"
  puts "4. Save the list"
  puts "5. Load  the list"
  puts "9. Exit"
end

def student_menu
  puts "1. List all the students"
  puts "2. List all the students sorted by cohorts"
  puts "3. List the students from a certain cohort"
  puts "4. List the students with names beginning with the letter _"
  puts "5. List the students with names shorter than _ characters"
  puts "6. List all students with index"
  puts "9. Return to previous menu"
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
    student_menu
    process2(STDIN.gets.chomp)
  when "3"
    puts "Type the number of the student that you would like to remove. (Leave empty to go back)"
    @students.each_with_index do |student, index| puts "#{index + 1}. #{student[:name]}" end
    delete = STDIN.gets.chomp.to_i
    if delete <= @students.count && delete > 0
      puts "You have deleted #{@students[delete - 1][:name]}"
      delete_student(delete)
    else return
    end
  when "4"
    puts "Enter the file which you wish to save as (Default: studentinfo.csv)"
    filesave = STDIN.gets.chomp
    filesave.empty? ? save_students : save_students(filesave)
  when "5"
    puts "Enter the file which you wish to load from (Default: studentinfo.csv)"
    fileload = STDIN.gets.chomp
    fileload.empty? ? load_students : load_students(fileload)
  when "9"
    exit 
  else
    puts "I don't know what you meant, try again"
  end
end

def process2(selection2)
  case selection2
  when "1"
    print_if_not_empty
  when "2"
    grouped_by_cohort
  when "3"
    puts "Would you like to see the April cohort or November cohort?"
    while true do
      cohort_selection = STDIN.gets.chomp
      capitalise(cohort_selection)
      if cohort_selection == "April"
        single_cohort("april")
        break
      elsif cohort_selection == "November"
        single_cohort("november")
        break
      end
    end
  when "4"
    puts "Which first letter names would you like to see?"
      while true do
        letter = STDIN.gets.chomp
          if letter.size == 1 && letter =~ /[a-zA-z]/
            name_begin_with(letter)
            break
          end
      end
  when "5"
    puts "What is the maximum length of name you would like to see?"
      while true do
        number = STDIN.gets.chomp.to_i
        if number.is_a? Integer
          name_shorter_than(number)
          break
        end
      end
  when "6"
      print_with_index
  when "9"
    return
  end
end   

def save_students(filename = "studentinfo.csv")
  CSV.open(filename, "w") do |csv|
    csv << ["name","cohort","hobby","country","height"]
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:hobby], student[:country], student[:height]]
      csv << student_data
    end
  end
  puts "You have saved the list of students into #{filename}"
end

def load_students(filename = "studentinfo.csv")
  @students = []
  CSV.foreach((filename), headers: true) do |row|
    add_student(row["name"], row["cohort"], row["hobby"], row["country"], row["height"])
  end
  puts "You have loaded #{@students.count} students from #{filename}"
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    if File.exists?("studentinfo.csv")
        load_students
      else return
      end
  elsif File.exists?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} does not exist"
  end
end

def add_student(name, cohort, hobby, country, height)
  @students << {name: name, cohort: cohort.to_sym, hobby: hobby, country: country, height: height}
end

def delete_student(index)
  @students[index - 1].compact.empty? ? nil : @students.delete(@students[index - 1]) 
end

def capitalise(word)
  if word =~ /[A-Z]/
    word = word.downcase!
  end
  word = word.capitalize!
end

puts $0
try_load_students
interactive_menu
