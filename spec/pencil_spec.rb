require './lib/pencil.rb'
require './lib/paper.rb'

describe 'pencil' do

    point_degrade_value = 1000

   # it 'writes text to a page' do
   #   paper = Paper.new
   #   pencil = Pencil.new
   #   test_string = 'Hello, world!'
   #   pencil.write_to_paper(paper, test_string)
   #
   #   expect(paper.get_text).to include(test_string)
   # end

  it 'has a value for point degradation' do
    pencil = Pencil.new
    pencil.set_degradation_value(point_degrade_value)
    expect(pencil.get_degradation_value).to eq(point_degrade_value)
  end
end
