require 'byebug'

class MaxIntSet
  def initialize(max)
    @max = max 
    @store = Array.new(max + 1, false) 

  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max && num >= 0
  end

  def validate!(num)
    raise "number is out of bounds of array" if !is_valid?(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num if self[num].empty?
    self[num].each.with_index do |integer,index|
      if num != integer 
        self[num] << num
      end
    end
  end

  def remove(num)
    self[num].each.with_index do |integer,index|
      if num == integer 
        self[num].delete_at(index)
      end
    end
  end

  def include?(num)
    self[num].each.with_index do |integer,index|
      return true if num == integer 
    end
    false
  end

  private

  def [](num)
    bucket_index = num % num_buckets
    bucket = @store[bucket_index]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count_eles

  def initialize(num_buckets = 1)
    @store = Array.new(num_buckets) { Array.new }
    @count_eles = 0
  end

  def insert(num)
    @count_eles += 1
    if @count_eles > @store.length
      new_store = new_buckets
      re_mod(new_store)
      @store = new_store  
    end
    self[num] << num

  end

  def remove(num)
    self[num].each_with_index do |el, idx| 
      self[num].delete_at(idx) if el == num
    end
  end

  def include?(num)
    self[num].each_with_index do |el, idx| 
      return true if el == num
    end
    false
  end

  def new_buckets
    num_buckets = @store.length * 2
    new_store = Array.new(num_buckets) { [] }
  end

  def re_mod(new_store)
    @store.each do |bucket|
      bucket.each do |ele|
        new_bucket_index = ele % new_store.length 
        new_store[new_bucket_index] << ele
      end
    end
  end

  private

  def [](num)
    bucket_index = num % num_buckets
    bucket = @store[bucket_index]
  end

  def num_buckets
    @store.length
  end

  # def resize!
  # end

end




