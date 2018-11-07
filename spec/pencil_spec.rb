require './lib/pencil.rb'
require './lib/paper.rb'

describe 'pencil' do

    point_degrade_value = 1000

       #Change paper value to hash to store text better
   it 'appends text to text already on paper' do
     paper = Paper.new
     pencil = Pencil.new
     init_text = 'She sells sea shells'
     test_string = ' down by the sea shore'
     paper.set_text(init_text)
     paper.set_text(pencil.write_to_paper(test_string))

     expect(paper.get_text).to match(init_text+test_string)
   end

  it 'has a value for point degradation' do
    pencil = Pencil.new
    pencil.set_degradation_value(point_degrade_value)
    expect(pencil.get_degradation_value).to eq(point_degrade_value)
  end
end
