require 'airport'

describe Airport do

  it 'instructs a plane to land and confirm that it landed' do
    plane = Plane.new
    allow(subject).to receive(:stormy?).and_return(false)
    expect(subject.land(plane)).to eq plane
  end

 it 'instructs a plane to take off' do
    plane = Plane.new
    allow(subject).to receive(:stormy?).and_return(false)
    subject.land(plane)
    expect(subject.take_off(plane)).to eq plane
  end

  it 'confirms that the plane is no longer in the airport' do
    expect(subject.planes).to be_empty
  end

  it 'prevents landing when weather is stormy' do
    allow(subject).to receive(:stormy?).and_return(true)
    expect{subject.land(Plane.new)}.to raise_error
  end

  it 'prevents taking-off when weather is stormy' do
    allow(subject).to receive(:stormy?).and_return(true)
    expect{subject.take_off(Plane.new)}.to raise_error
  end

  it 'prevents landing when the airport is full' do
    allow(subject).to receive(:stormy?).and_return(false)
    Airport::DEF_CAPACITY.times {subject.land(Plane.new)}
    expect{subject.land(Plane.new)}.to raise_error('Airport Full')
  end

  it 'assigns default airport capacity' do
    expect(subject.capacity).to eq 100
  end

  it  'allows capacity to be overridden' do
    expect(Airport.new(120).capacity).to eq 120
  end

  it 'lands and takes off a number of planes' do
    allow(subject).to receive(:stormy?).and_return(false)
    90.times{subject.land(Plane.new)}
    20.times{subject.take_off(Plane.new)}
    expect(subject.planes.count).to eq 70
  end


end
