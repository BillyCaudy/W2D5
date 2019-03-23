require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    if @count > @store.length
      new_store = new_buckets
      re_mod(new_store)
      @store = new_store  
    end
    self[key] << key
  end

  def include?(key)
    self[key].each_with_index do |el, idx| 
      return true if el == key
    end
    false
  end

  def remove(key)
    self[key].each_with_index do |el, idx| 
      self[key].delete_at(idx) if el == key
    end
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    bucket_index = key.hash % @store.length
    bucket = @store[bucket_index]
  end

  def new_buckets
    num_buckets = @store.length * 2
    new_store = Array.new(num_buckets) { [] }
  end

  # def resize!
  # end
  
  def re_mod(new_store)
    @store.each do |bucket|
      bucket.each do |key|
        new_bucket_index = key.hash % new_store.length 
        new_store[new_bucket_index] << key
      end
    end
  end

end
