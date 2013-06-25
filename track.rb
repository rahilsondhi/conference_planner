class Track
  MORNING_MAX_DURATION = 180
  AFTERNOON_MAX_DURATION = 240

  MORNING_START_TIME = Time.parse('9:00AM')
  LUNCH_TIME = Time.parse('12:00PM')
  AFTERNOON_START_TIME = Time.parse('1:00PM')

  attr_reader :name, :morning_talks, :afternoon_talks, :morning_duration, :afternoon_duration

  def initialize(name=nil)
    @name = name
    @morning_talks = []
    @afternoon_talks = []
    @morning_duration = 0
    @afternoon_duration = 0
  end

  def add_talk(talk)
    if !morning_full?(talk.duration)
      @morning_talks << talk
      @morning_duration += talk.duration
    elsif !afternoon_full?(talk.duration)
      @afternoon_talks << talk
      @afternoon_duration += talk.duration
    else
      raise TrackFullException
    end
  end

  # This track is full if the morning and afternoon session is full
  def full?(duration=0)
    (@morning_duration + @afternoon_duration + duration) > (MORNING_MAX_DURATION + AFTERNOON_MAX_DURATION)
  end

  # Check if the morning session duration exceeds its max
  # Optionally pass a duration to see if it will fit
  def morning_full?(duration=0)
    (@morning_duration + duration) > MORNING_MAX_DURATION
  end

  # Check if the afternoon session duration exceeds its max
  # Optionally pass a duration to see if it will fit
  def afternoon_full?(duration=0)
    (@afternoon_duration + duration) > AFTERNOON_MAX_DURATION
  end
end
