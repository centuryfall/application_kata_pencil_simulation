class Paper

  def initialize
    @paper_text = Array.new
  end

  def set_text(string)
    @paper_text.push(string)
  end

  def get_text
    @paper_text
  end
end
