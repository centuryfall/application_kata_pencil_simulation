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
  # This is different from editing text.
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
  end

  #Replaces the final sequence of characters given
  # Only replaces characters if the eraser degradation value is greater than zero.
  # Regex help from https://stackoverflow.com/a/16848676
  def erase(string_to_match, paper)
    whitespaces = ''
    string_to_match.reverse.split("").each {|x|
      whitespaces << (self.get_value(:eraser_degradation_value) > 0 &&
          string_to_match[x] !~ (/^(\s|\n)$/) ? ' ' : string_to_match[x])
      decrease_degradation_value(:eraser_degradation_value, string_to_match[x])
    }
    string_to_match = /(#{string_to_match})(?!.*\b#{string_to_match})/
    @last_erased_location = paper.get_text.index(string_to_match)
    paper.set_text(paper.get_text.sub(string_to_match, whitespaces.reverse))
  end

  #Fills in text at the last erased location on the page.
  # If the new character added collides with an existing character, an '@' is printed instead.
  def edit_text(replace_with_text, paper)
    edit_at_index = @last_erased_location
    begin
      edited_text = paper.get_text
      replace_with_text.split("").each_index do |replace_index|
        edited_text[edit_at_index + replace_index] = case
                                                       when edited_text[edit_at_index + replace_index] =~ (/\w/) && replace_with_text[replace_index] !~ (/^(\s|\n)/)
                                                         "@"
                                                       when edited_text[edit_at_index + replace_index] =~ (/\n/)
                                                         "\n#{replace_with_text[replace_index]}"
                                                       else
                                                         replace_with_text[replace_index]
                                                     end
      end
      paper.set_text(edited_text)
    end unless edit_at_index.nil?
  end
end

