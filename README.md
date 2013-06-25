# Conference Planner

## What is this?
This is a small Ruby application that takes a list of talks that have a name
and duration and creates a schedule for a conference. The conference can have
multiple tracks, the morning session is 9am-12pm, lunch is 12-1pm, the afternoon
session must start at 1pm and end at 5pm latest, and the networking event
must start after the afternoon session between 4 and 5pm.

## How do I run the application?
You can run the unit tests by doing `ruby spec.rb`. Everything will pass :).

You can also pass an input file to the executable by doing
`ruby conference_planner_executable.rb sample_input.txt` and it will print a
conference schedule for you. See `sample_input.txt` for an example.

## Why did you make this?
As part of the interview process for a company.

## Design notes
I thought about all the models that are required in this application:

1. Talk
2. Track
3. Conference

I broke the application into multiple small problems:

1. A method that takes a file and converts each line to a `Talk` with a name
and duration (regex).
2. A `Track` class that has two sessions (morning and afternoon) and a public
`add_talk` method that's responsible for inserting a `Talk` in one of the sessions.
3. A `Conference` class that contains multiple tracks, a public `plan` method that
creates `Tracks` and inserts `Talks`, and a public `schedule` method which prints
a schedule/timetable for the day.
4. A `ConferenceHelper` class with convenience methods like `format_time` so
time formatting is centralized in one place.
