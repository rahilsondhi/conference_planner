class Talk
  attr_reader :name, :duration

  def initialize(name, duration)
    @name = name
    @duration = duration
  end

  # Returns the duration of this talk
  # Options for `type` are integer (eg 45), text (eg 45min), or seconds (eg 2700)
  def duration(type='integer')
    case type
    when 'integer'
      return @duration
    when 'text'
      if @duration == 5
        return 'lightning'
      else
        return "#{duration}min"
      end
    when 'seconds'
      return @duration * 60
    end
  end

  # Given several lines of talks like "Writing Fast Tests Against Enterprise Rails 60min",
  # return an array of Talk instances with the name and duration set
  def self.from_string(lines)
    talks = []

    lines.split("\n").each do |line|
      data = /^(.*[^0-9])(\d+min|lightning)$/.match(line)
      name = data[1].strip
      duration = data[2] == 'lightning' ? 5 : data[2].gsub(/min/, '').to_i
      raise "Invalid talk: #{line}" if name.nil? || duration.nil?
      talks << Talk.new(name, duration)
    end

    talks
  end
end
