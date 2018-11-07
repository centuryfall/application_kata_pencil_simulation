require './lib/pencil.rb'
require './lib/paper.rb'

describe 'pencil' do

  point_degrade_value = 1000
  #Initialize a base pencil object
  pencil = Pencil.new
  pencil.set_degradation_value(point_degrade_value)

  #Writing to paper
  it 'appends text to existing text already on paper' do
    paper = Paper.new
    init_text = 'She sells sea shells'
    test_string = ' down by the sea shore'
    paper.set_text(init_text)
    paper.set_text(pencil.write(test_string))

    expect(paper.get_text).to match(init_text + test_string)
  end

  it 'adds text to paper if the paper has no text' do
    paper = Paper.new
    test_string = 'Hello, world!'
    paper.set_text(pencil.write(test_string))

    expect(paper.get_text).to match(test_string)
  end

  ######Graphite point degradation########

  describe 'Pencil point degradation'
  it 'sets a value for point degradation for a pencil' do
    pencil_test = Pencil.new
    pencil_test.set_degradation_value(point_degrade_value)
    expect(pencil_test.get_value(:degradation_value)).to eq(point_degrade_value)
  end

  context 'when determining point degradation' do
    pencil_test = Pencil.new
    init_val = 5
    it 'decreases its value by 1 if character given is a lowercase character' do
      string = 'a'
      pencil_test.set_degradation_value(init_val)
      pencil_test.decrease_degradation_value(string)
      expect(pencil_test.get_value(:degradation_value)).to eq(init_val - 1)
    end
    it 'decreases its value by 2 if character given is a uppercase character' do
      pencil_test = Pencil.new
      string = 'A'
      pencil_test.set_degradation_value(init_val)
      pencil_test.decrease_degradation_value(string)
      expect(pencil_test.get_value(:degradation_value)).to eq(init_val - 2)
    end
    it 'does not change its value if character given is a blank space or newline' do
      pencil_test = Pencil.new
      string = [" ", "\n"]
      string.each {
        pencil_test.set_degradation_value(init_val)
        pencil_test.decrease_degradation_value(string)
        expect(pencil_test.get_value(:degradation_value)).to eq(init_val)
      }
    end
  end

  context 'when writing a character' do
    pencil_test = Pencil.new
    init_val = 20
    it 'decreases the value for each character printed' do
      string = 'AB c'
      pencil_test.set_degradation_value(init_val)
      pencil_test.write(string)
      expect(pencil_test.get_value(:degradation_value)).to eq(init_val - 2 - 2 - 1)
    end

  end
  #and uppercase text degrades point val by 2
  #White spaces and newlines do not decrease point value (value does not change)

  #A pencil with a value of 0 writes white spaces for the remainder of the text

  #Comparison of higher and lower point values
end
