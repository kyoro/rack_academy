class SimpleValidator
  
  def initialize(data)
    @data = data
    @chain = []
  end

  def is_email
    @chain.push Proc.new { email_validator }
    self
  end

  def is_pubkey
    @chain.push Proc.new { pubkey_validator }
    self
  end

  def is_integer
    @chain.push Proc.new { integer_validator }
    self
  end

  def is_float
    @chain.push Proc.new { float_validator }
    self
  end
  
  def in_length *args
    @chain.push Proc.new { length_validator *args }
    self
  end

  def in_range *args
    @chain.push Proc.new { range_validator *args }
    self
  end

  def in_array *args
    @chain.push Proc.new { array_validator *args }
    self
  end

  def in_partial *args
    @chain.push Proc.new { match_partial_validator *args }
    self
  end

  def result
    return @result if !@result.nil?
    @chain.each do | solver |
      return @result = false unless solver.call
    end
    @result = true
  end

  private
  def email_validator
    false if @data.blank?
    return true if /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/ =~ @data
    false
  end

  def pubkey_validator
    false if @data.blank?
    return true if  @data =~ /^[\s\n\r]*((ssh\-dss)|(ssh\-rsa))\s.+/
    false
  end

  def integer_validator
    false if @data.to_s.blank?
    return true if  @data.to_s =~ /^[0-9]+$/
    false
  end

  def float_validator
    false if @data.to_s.blank?
    return true if  @data.to_s =~ /^[0-9]+\.[0-9]+$/
    false
  end

  def length_validator min, max=nil
    false if @data.nil? || @data.class != String
    if max.nil? && min.nil?
      raise "arguments error." 
    elsif !max.nil? && !min.nil?
      return true if @data.size <= max && @data.size >= min
    elsif max.nil?
      return true if @data.size >= min
    elsif min.nil?
      return true if @data.size <= max
    end
    false
  end
  
  def range_validator min, max
    return false if @data.nil?
    if min.nil? || max.nil?
      raise "arguments error."
    else
      return true if @data.to_i >= min.to_i && @data.to_i <= max.to_i
    end
    return false
  end

  def array_validator list
    return false if @data.nil?
    return false if list.nil?
    list.each do |key|
      return true if @data.to_s == key.to_s
    end
    return false
  end

  def match_partial_validator list
    return false if @data.nil?
    return false if list.nil?
    list.each do |key|
      return true unless @data.to_s.index(key.to_s).nil?
    end
    return false
  end

end
