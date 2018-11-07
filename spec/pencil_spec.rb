require './lib/pencil.rb'
require './lib/paper.rb'

describe 'pencil' do

  point_degrade_value = 1000

  #Writing to paper
  it 'appends text to existing text already on paper' do
    paper = Paper.new
    pencil = Pencil.new
    init_text = 'She sells sea shells'
    test_string = ' down by the sea shore'
    paper.set_text(init_text)
    paper.set_text(pencil.write_to_paper(test_string))

    expect(paper.get_text).to match(init_text + test_string)
  end

  it 'adds text to paper if the paper has no text' do
    paper = Paper.new
    pencil = Pencil.new
    test_string = 'Hello, world!'
    paper.set_text(pencil.write_to_paper(test_string))

    expect(paper.get_text).to match(test_string)
  end

  #Graphite point degradation
  it 'has a value for point degradation' do
    pencil = Pencil.new
    pencil.set_degradation_value(point_degrade_value)
    expect(pencil.get_degradation_value).to eq(point_degrade_value)
  end
end
