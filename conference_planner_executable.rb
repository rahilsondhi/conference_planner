# Usage: ruby conference_planner_executable sample_input.txt

# Require the application
require_relative 'conference_planner'

# Open the data file
file = File.open(ARGV[0], 'rb')
contents = file.read

# Convert the contents of the data file to an array of Talk objets
talks = Talk.from_string(contents)

# Create a new conference, plan all the talks, then print the schedlue
c = Conference.new
puts c.plan(talks).schedule
