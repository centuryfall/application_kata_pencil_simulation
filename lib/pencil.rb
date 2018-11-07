class Pencil

  def initialize
    @values = Hash.new
    @values[:degradation_value]
  end

  def set_degradation_value(val)
    @values[:degradation_value] = val
  end

  def get_value(value)
    @values[value]
  end

  #Decrases the value of the graphite point depending on the type of character given
  def decrease_degradation_value(given_character)
    if given_character =~ (/^(\s|\n)$/)
    elsif given_character =~ (/^[[:upper:]]$/)
      self.set_degradation_value(self.get_value(:degradation_value) - 2)
    elsif given_character =~ (/^[[:lower:]]|\S$/) && given_character !~ (/^[[:upper:]]$/)
      self.set_degradation_value(self.get_value(:degradation_value) - 1)
    end
  end

  #Writes text per each character. If the point value is 0, character returned is blank.
  def write(text)
    text.split("").each_with_index do |val, index|
      decrease_degradation_value(val)
      text[index] = val
    end
    text
  end
end
