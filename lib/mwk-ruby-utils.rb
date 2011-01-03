class Array
  def present_join(in_delim=", ")
    self.select {|x| (x || '').strip != ""}.join(in_delim)
  end
  
  def hashify_single(in_sym=nil)
    res = {}
    self.each do |iter_el|
      res[in_sym.nil? ? iter_el : iter_el.send(in_sym)] = iter_el
    end
    res
  end
end

