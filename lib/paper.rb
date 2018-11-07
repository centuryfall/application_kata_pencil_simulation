class Paper

  def initialize
    @paper_text = String.new
  end

  def set_text(string)
    @paper_text += string
  end

  def get_text
    @paper_text
  end
end
