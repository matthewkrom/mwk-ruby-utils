class Array
  def present_join(delim=", ")
    self.select {|x| (x || '').strip != ""}.join(delim)
  end
end