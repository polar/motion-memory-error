
class MyObject
  @@count = 0
  attr_reader :name
  def initialize(name)
    @@count += 1
    @name = "#{name} #{@@count}"
  end
end
class AppDelegate < PM::Delegate

  def on_load(app, options = {})
    @bgQueue = Dispatch::Queue.new("background")
    @fgQueue = Dispatch::Queue.current
    setupTimer
    doLotsOfStuff1
    puts "Dispatched"
    open PM::Screen.new
  end

  def setupTimer
    1.second.every do
      puts "Timer: Tic1"
      puts "Timer: Tic2 #{[]}"
    end
  end

  def doStuff(n)
    puts "doStuff(#{n})"
    puts "doStuff2 #{[]}"
    for i in 0..1000 do
      object = MyObject.new("This is an object")
      #puts "#{object} : #{object.name}"
    end
  end

  def doLotsOfStuff(n)
    puts "doLotsOfStuff(#{n})"
    puts "doLotsOfStuff make array #{[]}"
    @bgQueue.async do
      doStuff(n)
      doLotsOfStuff(n+1)
    end
  end

  def doLotsOfStuff1
    puts "doLotsOfStuff1"
    puts "doLotsOfStuff1 make array #{[]}"
    @bgQueue.async do
      doStuff(0)
      doLotsOfStuff1
    end
  end
end
