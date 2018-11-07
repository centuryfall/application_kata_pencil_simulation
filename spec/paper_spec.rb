require './lib/paper.rb'

describe 'paper' do

  it 'can contain text' do
    paper = Paper.new
    test_string = "She sells sea shells"
    paper.set_text(test_string)
    expect(paper.get_text).to include(test_string)
  end
end
