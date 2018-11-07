require './lib/pencil.rb'
require './lib/paper.rb'

describe 'pencil' do

  #Initialize a base pencil object
  point_degrade_value = 1000
  length = 10
  pencil = Pencil.new(point_degrade_value, length)

  it 'has a length' do
    expect(pencil.get_value(:length)).to eq length
  end

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

  ######Graphite point degradation description########

  describe 'Pencil point degradation'
  it 'sets a value for point degradation for a pencil' do
    pencil_test = Pencil.new(point_degrade_value, length)

    expect(pencil_test.get_value(:degradation_value)).to eq(point_degrade_value)
  end

  context 'when determining point degradation' do
    init_val = 5
    pencil_test = Pencil.new(init_val, 10)
    it 'decreases its value by 1 if character given is a lowercase character' do
      string = 'a'
      pencil_test.set_degradation_value(init_val)
      pencil_test.decrease_degradation_value(string)

      expect(pencil_test.get_value(:degradation_value)).to eq(init_val - 1)
    end

    it 'decreases its value by 2 if character given is a uppercase character' do
      pencil_test = Pencil.new(init_val, 10)
      string = 'A'
      pencil_test.set_degradation_value(init_val)
      pencil_test.decrease_degradation_value(string)

      expect(pencil_test.get_value(:degradation_value)).to eq(init_val - 2)
    end

    it 'does not change its value if character given is a blank space or newline' do
      pencil_test = Pencil.new(init_val, 10)
      string = [" ", "\n"]
      string.each {
        pencil_test.set_degradation_value(init_val)
        pencil_test.decrease_degradation_value(string)

        expect(pencil_test.get_value(:degradation_value)).to eq(init_val)
      }
    end
  end

  context 'when writing a character' do
    init_val = 20
    pencil_test = Pencil.new(init_val, 10)
    it 'decreases the value for each character printed' do
      string = 'AB c'
      pencil_test.write(string)

      expect(pencil_test.get_value(:degradation_value)).to eq(init_val - 2 - 2 - 1)
    end

    #Currently it's setting the string input equal to what it should be if the point value is 0
    # Should fix that later
    it 'prints blank characters after its point degradation reaches 0' do
      init_val = 20
      pencil_test = Pencil.new(init_val, 10)
      paper = Paper.new
      string = 'ABCDEFGHIJklmnop'
      paper.set_text(pencil_test.write(string))
      sleep 2
#      expect(paper.get_text).to_not eq(string)

      expect(paper.get_text).to_not eq('ABCDEFGHIJklmnop')
      expect(paper.get_text).to eq('ABCDEFGHIJ      ')
    end

    it 'prints more characters for a pencil with a higher point degradation value than its string input' do
      pencil_1 = Pencil.new(10, 10)
      pencil_2 = Pencil.new(6, 10)
      paper_1 = Paper.new
      paper_2 = Paper.new
      string = 'ABCD'
      paper_1.set_text(pencil_1.write(string))
      paper_2.set_text(pencil_2.write(string))

      expect(paper_1.get_text).to_not eq(paper_2.get_text)
    end
  end

  context 'when sharpened' do
    init_point_value = 10
    length = 10
    pencil_test = Pencil.new(init_point_value, length)
    it 'regains its initial point value' do
      pencil_test = Pencil.new(init_point_value, length)
      pencil_test.set_degradation_value(5)
      pencil_test.sharpen

      expect(pencil_test.get_value(:degradation_value)).to eq(init_point_value)
    end

    it 'decreases its length value by 1' do
      pencil_test = Pencil.new(init_point_value, length)
      pencil_test.sharpen

      expect(pencil_test.get_value(:length)).to eq(length - 1)
    end

    it 'does not regain its point value if its length is 0' do
      pencil_test = Pencil.new(init_point_value, 2)
      3.times {
        pencil_test.write('ABCDE')
        pencil_test.sharpen
      }
      expect(pencil_test.get_value(:degradation_value)).to eq(0)
    end
  end
end
