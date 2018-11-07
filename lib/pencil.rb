class Pencil

  def initialize(init_point_grade, init_length)
    @max_point_grade = init_point_grade
    @max_length = init_length
    @values = Hash.new
    @values[:degradation_value] = init_point_grade
    @values[:length] = init_length
  end

  def set_degradation_value(val)
    @values[:degradation_value] = val
  end

  def set_length(val)
    @values[:length] = val
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
  def write(text, to_paper)
    text.split("").each_with_index do |val, index|
      text[index] = (self.get_value(:degradation_value) > 0) ? val : " "
      decrease_degradation_value(val)
    end
    to_paper.set_text(text)
  end

  def sharpen
    if self.get_value(:length) > 0
      self.set_length(self.get_value(:length) - 1)
      self.set_degradation_value(@max_point_grade)
    end
  end
end
