class Languages::Ruby

  def initialize(year : Int32, day : Int32)
    @year = year
    @day = day
  end

  def setup_code
    puts "Hello from the 💎 world for #{@day}-#{@year}"
  end
end
