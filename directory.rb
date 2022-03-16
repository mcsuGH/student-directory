@students = []
require 'csv'

def input_students
  puts "Enter the names of the students"
  puts "When finished, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "Is the student in the April or November cohort? (Default: November)"
    while true do 
      cohort = STDIN.gets.chomp
      cohort.empty? ? cohort = "november" : cohort
      capitalise(cohort)
      if cohort == "November" || cohort == "April"
        break
      end
    end
    add_student(name, cohort)
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
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
  CSV.open(filename, "w") do |csv|
    csv << ["name","cohort"]
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv << student_data
    end
  end
  puts "You have saved the list of students into #{filename}"
end

def load_students(filename = "students.csv")
  @students = []
  CSV.foreach((filename), headers: true) do |row|
    add_student(row["name"], row["cohort"])
  end
  puts "You have loaded #{@students.count} students from #{filename}"
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    if File.exists?("students.csv")
      load_students
      puts "Loaded #{@students.count} from students.csv by default"
    else return
    end
  elsif File.exists?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} does not exist"
    exit
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def capitalise(word)
  if word =~ /[A-Z]/
    word = word.downcase!
  end
  word = word.capitalize!
end

try_load_students
interactive_menu