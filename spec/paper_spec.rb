require_relative '../lib/paper.rb'
require 'rspec'

describe 'paper' do

  #Intiial values
  it 'can contain text' do
    paper = Paper.new
    test_string = "She sells sea shells"
    paper.set_text(test_string)
    expect(paper.get_text).to include(test_string)

    it 'can add text to it' do
      paper = Paper.new
      test_string = "She sells sea shells"
      second_string = " down by the sea shore"
      paper.set_text(test_string)
      paper.add_text(second_string)
      expect(paper.get_text).to match(test_string + test_string)
    end
  end
end
