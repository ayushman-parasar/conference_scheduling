require_relative "talk"
class Sessions
  def initialize
    @morning_talks1 = []
    @available_morning_mins_for_track1 = 180

  end

  def adding_programs
    Talk.list.each do |talk|
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
  end
end

Sessions.new.adding_programs