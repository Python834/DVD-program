############################################################
#
#  Name:        Patrick McManis
#  Assignment:  timer
#  Date:        4/24/2014
#  Class:        CIS 283
#  Description: create a program that runs a DVD
#
############################################################
class Dvd
  def initialize
    @inserted = false
    @play = 0
    @stop = 0
    @fast_forward = 0
    @rewind = 0
    @elapsed = 0
    @running = false
  end
  def insert
    if !@inserted
      @inserted = true
      puts 'Disk inserted'
    else
      puts 'Disk already inserted'
    end
  end
  def play
    if @elapsed == 7200
      puts 'The End, please rewind.'
    else
      if @elapsed == 0
        @play = Time.now.to_i
        @elapsed += Time.now.to_i - @play
      else
        @play = Time.now.to_i - @elapsed
      end
      if @inserted
        if !@running
          puts "Playing at #{@elapsed} seconds."
          @running = true
        else
          puts 'Already playing.'
        end
      else
        puts 'Please insert disk.'
      end
    end
  end
  def rewind( time )
    if @inserted
      @elapsed -= time
      if @elapsed < 0
        @elapsed = 0
      end
      puts "Rewound to #{@elapsed} seconds."
    else
      puts 'Must insert Disk'
    end
  end
  def fast_forward( time )
    if @inserted
      @elapsed += time
      if @elapsed > 7200
        @elapsed = 7200
      end
      puts "Fast forwarded to #{@elapsed} seconds."
    else
       puts 'Must insert Disk'
    end
  end
  def stop
    @stop = Time.now.to_i
    if @running
      @elapsed = @stop - @play
      puts "Stopped at #{@elapsed} seconds."
    else
      puts 'Already stopped.'
    end
    @running = false
  end
  def eject
    if @inserted
      @inserted = false
      @running = false
      @elapsed = 0
      puts 'Disk ejected'
    else
      puts 'No disk found.'
    end
  end
  def to_s
    if @running
      @elapsed = Time.now.to_i - @play
    elsif !@running
      @elapsed = @stop - @play
    elsif !@inserted
      @elapsed = 0
    end
    return "Disk inserted: #{@inserted} \nDVD play time: #{@elapsed} \nDisk running: #{@running}."
  end
end

def menu
  puts
  puts '1. Insert Disk'
  puts '2. Play Disk'
  puts '3. Rewind Disk'
  puts '4. Fast Forward Disk'
  puts '5. Stop Disk'
  puts '6. Eject Disk'
  puts '7. Show Current Disk Status'
  puts '8. Quit'
  print 'Enter your selection: '
  return gets.to_i

end

my_dvd = Dvd.new
while (user_selection = menu) != 8
  if user_selection > 0
    if user_selection == 1
      puts
      my_dvd.insert
    elsif user_selection == 2
      puts
      my_dvd.play
    elsif user_selection == 3
      puts
      puts 'Enter rewind number.'
      my_dvd.rewind(gets.to_i)
    elsif user_selection == 4
      puts
      puts 'Enter fast forward number.'
      puts
      my_dvd.fast_forward(gets.to_i)
    elsif user_selection == 5
      puts
      my_dvd.stop
    elsif user_selection == 6
      puts
      my_dvd.eject
    elsif user_selection == 7
      puts
      puts my_dvd.to_s
    end
  else
    puts
    puts 'Please enter valid menu option.'
end
end