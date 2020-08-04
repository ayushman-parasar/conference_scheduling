class Track
  attr_accessor :name, :array
  def initialize(name, array)
    @name = name
    @array = array
  end

  

  def show_track
    if @name == "Track1"
      puts @name
      picture(array)
      puts "--------------------------------- \n-------------------------------------\n"
    else
      puts "Track2"
      picture(array)
    end
  end

  def picture(arr)
    @start_time_morning = Time.local(2020, 03, 03, 9)
    arr[0].map do |talk|
      talk.each do |key,value|
        puts "#{@start_time_morning.strftime("%I:%M %p")} #{key}   #{value} min"
        @start_time_morning += value.to_i * 60
      end
    end
    
    puts "\n Lunch from 12:00 PM to 01:00 PM "
    puts "\n"
    @start_time_evening = Time.local(2020, 03, 03, 13)
    arr[1].map do|talk|
      show_time = @start_time_evening
      talk.each do |key,value|
        puts "#{@start_time_evening.strftime("%I:%M %p")} #{key}   #{value} min"
        @start_time_evening += value.to_i * 60
      end
    end
   
  end
end