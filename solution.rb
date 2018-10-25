require 'benchmark'

class Emerald
  attr_accessor :value, :prev, :next

  def initialize(value)
    @value = value
    @prev = nil
    @next = nil
  end
end

class Diamond
  attr_accessor :head

  def initialize(emerald)
    @head = emerald
  end

  def append(emerald)
    current_emerald = @head
    while !current_emerald.next.nil?
      current_emerald = current_emerald.next
    end

    current_emerald.next = emerald
    emerald.prev = current_emerald
  end

  def delete(emerald)
    if emerald.prev.nil?
      @head = emerald.next
    end

    if !emerald.prev.nil?
      emerald.prev.next = emerald.next
    end

    if !emerald.next.nil?
      emerald.next.prev = emerald.prev
    end
  end

  def print
    emerald = @head
    return if emerald.nil?

    loop do
      puts emerald.value
      emerald = emerald.next
      break if emerald.nil?
    end
  end
end

# a = Emerald.new('a')
# b = Emerald.new('b')
# c = Emerald.new('c')

# diamond = Diamond.new(a)
# diamond.append(b)
# diamond.append(c)
# diamond.print

# puts 'deleting b'
# diamond.delete(b)

# diamond.print

# Set up the data structure first
arr = (1..20000).to_a

# === Set up your Diamonds and Emeralds here! ===
diamond = Diamond.new(Emerald.new(1))
19999.times { diamond.append(Emerald.new(1)) }

# ===============================================

# Start the first timestamp only after the data structure has been set up, so that we only time the duration of the element removals
Benchmark.bm do |bm|
  puts "Removal of elements from array"
  bm.report do
    while (arr.size > 1) do
      arr.slice!(1, 1)
    end
  end

  puts "Removal of Emeralds from Diamond"
  bm.report do
    # === Insert your code to remove Emeralds from Diamonds here ===
    while (diamond.head.next != nil)
      diamond.delete(diamond.head.next)
    end
  end
end
