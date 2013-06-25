class Conference
  attr_reader :tracks, :number_of_talks

  def initialize
    @tracks = []
    @number_of_talks = 0
  end

  def new_track
    track_name = @tracks.length + 1
    Track.new(track_name)
  end

  # Given a large set of talks, create new tracks and fill them with talks
  def plan(talks)
    # Create the first track to add talks to
    track = self.new_track

    # Iterate through all the talks
    # When we get a TrackFullException, append the current track to @tracks, create a new track, and continue adding talks
    talks.each do |talk|
      begin
        track.add_talk(talk)
        @number_of_talks += 1
      rescue TrackFullException
        @tracks << track
        track = self.new_track
        retry
      end
    end

    # Append the last track to @tracks
    @tracks << track

    # Return the conference to allow chaining
    self
  end

  # Print a schedule of the conference
  def schedule
    output = ""

    @tracks.each do |track|
      output += "Track #{@tracks.index(track) + 1}:\n"

      elapsed_time = 0
      track.morning_talks.each do |talk|
        output += "#{ConferenceHelper.format_time(Track::MORNING_START_TIME + elapsed_time)} #{talk.name} #{talk.duration('text')}\n"
        elapsed_time += talk.duration('seconds')
      end

      output += "#{ConferenceHelper.format_time(Track::LUNCH_TIME)} Lunch\n"

      elapsed_time = 0
      track.afternoon_talks.each do |talk|
        output += "#{ConferenceHelper.format_time(Track::AFTERNOON_START_TIME + elapsed_time)} #{talk.name} #{talk.duration('text')}\n"
        elapsed_time += talk.duration('seconds')
      end

      output += "#{ConferenceHelper.format_time(Track::AFTERNOON_START_TIME + elapsed_time)} Networking Event\n"

      output += "\n" # Empty line to separate tracks
    end
    output
  end
end
