require_relative "talk_list"

class Talk 
  include Alltalks
  attr_accessor :lightning_talks

  def initialize
    @lightning_talks = lightning_talks
    @array_hash = [] 
  end

  def self.list
    new.gather_lightning_talks
  end

  def gather_lightning_talks
    @lightning_talks = Alltalks::TALKLIST.map do |item|
      item if item.include?("lightning talk") 
    end.compact
    structure_talks
  end

  def structure_talks
    (Alltalks::TALKLIST - lightning_talks).each do |talk|
      item_array = talk.split(" ")
      time = item_array[item_array.length - 2]
      @array_hash << {item_array[0..-3].join(" ") => time}
    end
    
    @array_hash
  end

end

Talk.list
