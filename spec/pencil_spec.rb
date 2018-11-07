require './lib/pencil.rb'

describe 'pencil' do
    pencil = Pencil.new
    degradation_value = 1000

  it 'has a value for point degradation' do
    expect(pencil.get_degradation_value).to eq(degradation_value)
  end
end
