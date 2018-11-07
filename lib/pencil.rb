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
    decrease_by =
        if given_character =~ (/^[[:upper:]]$/) && given_character !~ (/^(\s|\n)$/)
          2
        elsif given_character =~ (/^[[:lower:]]|\S$/) && given_character !~ (/^[[:upper:]]$/) && given_character !~ (/^(\s|\n)$/)
          1
        else
          0
        end
    self.set_degradation_value(self.get_value(:degradation_value) - decrease_by) unless self.get_value(:degradation_value) <= 0
  end

  #Writes text per each character. If the point value is 0, character returned is blank.
  #Currently it's setting the string input equal to what it should be if the point value is 0
  def write(text)
    text.split("").each_with_index do |val, index|
      text[index] = (self.get_value(:degradation_value) > 0) ? val : " "
      decrease_degradation_value(val)
    end
    text
  end
end
