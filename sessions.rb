require_relative "talk"
class Sessions
  def initialize
    @morning_talks1 = []
    @available_morning_mins_for_track1 = 180
    @array = Talk.list
    @call = 1
    @call_evening = 1
  end

  def adding_programs
    @array.each do |talk|
      talk.each do |key, value|
        if @available_morning_mins_for_track1 == 0
          break
        else
          @morning_talks1 << {key =>value}
          @available_morning_mins_for_track1 = @available_morning_mins_for_track1.to_i -  value.to_i
        end
      end
    end
    p "morning session for track1 #{@morning_talks1}"
    remove_over_talks(@morning_talks1)
  end

  def remove_over_talks(items)
    result = []
    @array.each do |hsh|
      hsh.each do |key, value|
        for hass in items
          if hass[key]
            result << hass
          end
        end
      end
    end
    @array = @array - result
    if @call == 1
      @call += 1
      p @array, "after removing"
    else
      @array
    end
  end
end

Sessions.new.adding_programs