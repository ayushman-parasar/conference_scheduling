require_relative "talk"
require_relative "track"
class Sessions
  def initialize
    @array = Talk.list
    @morning_talks1 = []
    @morning_talks2 = []
    @call = 1
    @available_morning_mins_for_track2 = @available_morning_mins_for_track1 = 180
    @batch_for_eveningtalks = [] 
    @evening_talks1 = []
    @evening_talks2 = []
    @call_evening = 1
    @available_evening_mins_for_track1 = @available_evening_mins_for_track2 = 240
       
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
      adding_morning_talks_track2(@array)
    else
      @array
    end
  end
  
  def adding_morning_talks_track2(array_of_hsh)
    array_of_hsh.each do |hsh|
      hsh.each do |key, value|
        if @available_morning_mins_for_track2 == 0
          break
        else
          @morning_talks2 << {key=>value}
          @available_morning_mins_for_track2 = @available_morning_mins_for_track2.to_i -  value.to_i
          break
        end
      end
    end
    @batch_for_eveningtalks =  remove_over_talks(@morning_talks2)
    
    adding_evening_talks_track1 
  end

  def including_lighningtalk
    @lightning_talks = Alltalks::TALKLIST.map do |item|
      item if item.include?("lightning talk")
    end.compact
    @lightning_talks.map {|item| {item => "5"}}
  end

  def adding_evening_talks_track1
    @batch_for_eveningtalks.each do |talk|
      talk.each do |key, value|
        if @available_evening_mins_for_track1 == 0
          break
        else
          @evening_talks1 << {key=>value}
          @available_evening_mins_for_track1 = @available_evening_mins_for_track1.to_i -  value.to_i
        end
      end
    end
    
    remove_over_talks_evening(@evening_talks1)
  end

  def remove_over_talks_evening(items)
    result = []
    @batch_for_eveningtalks.each do |hsh|
      hsh.each do |key, value|
        for hass in items
          if hass[key]
            result << hass
          end
        end
        
      end
    end
    @batch_for_eveningtalks = @batch_for_eveningtalks - result
    if @call_evening == 1
      @call_evening += 1
      adding_evening_talks_track2(@batch_for_eveningtalks)
    else
      @evening_talks2
    end
  end

  def adding_evening_talks_track2(array)
    combined_array = array +  including_lighningtalk
    combined_array.each do |talk|
      talk.each do |key, value|
        if @available_evening_mins_for_track2 == 0
          break
        else
          @evening_talks2 << {key => value}
          @available_evening_mins_for_track2 = @available_evening_mins_for_track2.to_i -  value.to_i
          
        end
      end
    end
    remove_over_talks_evening(@evening_talks1)
    add_to_track("Track1",[@morning_talks1,@evening_talks1])
    add_to_track("Track2",[@morning_talks2,@evening_talks2])
  end
  
  def add_to_track(str, array)
    Track.new(str, array).show_track
  end
  
end
