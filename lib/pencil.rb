class Pencil

  def initialize(init_point_grade, init_length, init_eraser_grade)
    @max_point_grade = init_point_grade
    @max_length = init_length
    @values = Hash.new
    @values[:point_degradation_value] = @max_point_grade
    @values[:length] = @max_length
    @values[:eraser_degradation_value] = init_eraser_grade
  end

  def set_degradation_value(degrade_type, val)
    @values[degrade_type] = val
  end

  def get_value(value)
    @values[value]
  end

  #Decrases the value of the graphite point depending on the type of character given
  def decrease_degradation_value(degrade_type, given_character)
    decrease_by =
        case degrade_type
        when :point_degradation_value
          if given_character =~ (/^[[:upper:]]$/) && given_character !~ (/^(\s|\n)$/)
            2
          elsif given_character =~ (/^[[:lower:]]|\S$/) && given_character !~ (/^[[:upper:]]$/) && given_character !~ (/^(\s|\n)$/)
            1
          else
            0
          end
        when :eraser_degradation_value
          given_character !~ (/^(\s|\n)$/) ? 1 : 0
        end
    self.set_degradation_value(degrade_type, self.get_value(degrade_type) - decrease_by) unless self.get_value(degrade_type) <= 0
  end

  #Writes text per each character. If the point value is 0, character returned is blank.
  #Currently it's setting the string input equal to what it should be if the point value is 0
  def write(text, to_paper)
    text.split("").each_with_index do |val, index|
      text[index] = (self.get_value(:point_degradation_value) > 0) ? val.sub("\'", "'") : " "
      decrease_degradation_value(:point_degradation_value, val)
    end
    to_paper.add_text(text)
  end

  #Sets the graphite point value back to its original max_point_grade, and then decreases the length by 1. Does not reset if length equal to or less than 0.
  def sharpen
    if self.get_value(:length) > 0
      self.set_degradation_value(:length, self.get_value(:length) - 1)
      self.set_degradation_value(:point_degradation_value, @max_point_grade)
    end

    #Replaces the final sequence of characters given
    # Only replaces characters if the eraser degradation value is greater than zero.
    # Regex help from https://stackoverflow.com/a/16848676
    def erase(string_to_match, paper)
      whitespaces = ''
      string_to_match.split("").each {|x|
        whitespaces << (self.get_value(:eraser_degradation_value) > 0 &&
            string_to_match[x] !~ (/^(\s|\n)$/) ? ' ' : string_to_match[x])
        decrease_degradation_value(:eraser_degradation_value, string_to_match[x])
      }
      string_to_match = /(#{string_to_match})(?!.*\b#{string_to_match})/
      paper.set_text(paper.get_text.sub(string_to_match, whitespaces))
    end

    def edit_text(replace_with_text, paper)
      spaces = paper.get_text.index(/\s{2,}/)
      if spaces.nil?

      else
        edited_text = paper.get_text
        replace_index = 0
        (spaces..(spaces + replace_with_text.length)).each do |index|
          if (spaces + replace_with_text.length) >= index
            edited_text += replace_with_text[replace_index]
          else
            edited_text[index] = case
                                 when edited_text[index] =~ (/\w/) && replace_with_text[replace_index] !~ (/^(\s|\n)/)
                                   '@'
                                 else
                                   replace_with_text[replace_index]
                                 end
          end
          replace_index += 1
        end
        paper.set_text(edited_text)
      end
    end
  end
end
