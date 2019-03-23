class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.each_with_index.reduce(0) do |hash_in_progress, (el, i)| 
      (el.hash + i.hash) ^ hash_in_progress
    end
  end
end

class String
  def hash
    self.to_a.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
