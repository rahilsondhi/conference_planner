require 'test/unit'
require_relative 'conference_planner'

class TalkTests < Test::Unit::TestCase
  def test_from_string
    talks = Talk.from_string("Writing Fast Tests Against Enterprise Rails 60min\nOverdoing it in Python 45min\nRails for Python Developers lightning")
    assert_equal talks.length, 3
    assert_equal talks.map(&:name), ['Writing Fast Tests Against Enterprise Rails', 'Overdoing it in Python', 'Rails for Python Developers']
    assert_equal talks.map(&:duration), [60, 45, 5]
  end
end

class TrackTests < Test::Unit::TestCase
  def test_morning_full?
    track = Track.new
    assert_equal track.morning_full?(Track::MORNING_MAX_DURATION + 1), true
    assert_equal track.morning_full?(Track::MORNING_MAX_DURATION), false
  end

  def test_afternoon_full?
    track = Track.new
    assert_equal track.afternoon_full?(Track::AFTERNOON_MAX_DURATION + 1), true
    assert_equal track.afternoon_full?(Track::AFTERNOON_MAX_DURATION), false
  end

  def test_full?
    track = Track.new
    assert_equal track.full?(Track::MORNING_MAX_DURATION + Track::AFTERNOON_MAX_DURATION + 1), true
    assert_equal track.full?(Track::MORNING_MAX_DURATION + Track::AFTERNOON_MAX_DURATION), false
  end
end

class ConferenceTests < Test::Unit::TestCase
  def test_plan
    input = "Writing Fast Tests Against Enterprise Rails 60min\nOverdoing it in Python 45min\nLua for the Masses 30min\nRuby Errors from Mismatched Gem Versions 45min\nCommon Ruby Errors 45min\nRails for Python Developers lightning\nCommunicating Over Distance 60min\nAccounting-Driven Development 45min\nWoah 30min\nSit Down and Write 30min\nPair Programming vs Noise 45min\nRails Magic 60min\nRuby on Rails: Why We Should Move On 60min\nClojure Ate Scala (on my project) 45min\nProgramming in the Boondocks of Seattle 30min\nRuby vs. Clojure for Back-End Development 30min\nRuby on Rails Legacy App Maintenance 60min\nA World Without HackerNews 30min\nUser Interface CSS in Rails Apps 30min"
    talks = Talk.from_string(input)
    c = Conference.new
    assert_equal c.plan(talks).tracks.length, 2
    assert_equal c.number_of_talks, 19
    assert_equal c.schedule, "Track 1:\n09:00AM Writing Fast Tests Against Enterprise Rails 60min\n10:00AM Overdoing it in Python 45min\n10:45AM Lua for the Masses 30min\n11:15AM Ruby Errors from Mismatched Gem Versions 45min\n12:00PM Lunch\n01:00PM Common Ruby Errors 45min\n01:45PM Rails for Python Developers lightning\n01:50PM Communicating Over Distance 60min\n02:50PM Accounting-Driven Development 45min\n03:35PM Woah 30min\n04:05PM Sit Down and Write 30min\n04:35PM Networking Event\n\nTrack 2:\n09:00AM Pair Programming vs Noise 45min\n09:45AM Rails Magic 60min\n10:45AM Ruby on Rails: Why We Should Move On 60min\n12:00PM Lunch\n01:00PM Clojure Ate Scala (on my project) 45min\n01:45PM Programming in the Boondocks of Seattle 30min\n02:15PM Ruby vs. Clojure for Back-End Development 30min\n02:45PM Ruby on Rails Legacy App Maintenance 60min\n03:45PM A World Without HackerNews 30min\n04:15PM User Interface CSS in Rails Apps 30min\n04:45PM Networking Event\n\n"
  end
end
