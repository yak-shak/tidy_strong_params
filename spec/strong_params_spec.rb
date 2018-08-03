require 'spec_helper'
require 'fixtures/params/original_gangster_strong_params'
require 'fixtures/raw_params'

RSpec.describe TidyStrongParams::StrongParams do
  let(:raw_params) { RawParameters.original_gangster_params }
  let(:resource_name) { 'original_gangster' }
  subject { OriginalGangsterStrongParams.build_list(raw_params: raw_params, resource_name: resource_name) }

  it 'allows listed params' do
    expect(subject.keys).to include('infamy')
    expect(subject['infamy']).to eq(8)
  end

  it 'rejects non listed params' do
    expect(subject.keys).to_not include(:name)
  end

  it 'supports arrays' do
    expect(subject['cities']).to eq(%w[York London Lisbon])
  end

  it 'supports nested params' do
    expect(subject['henchmen'].last['first_name']).to eq('Steve')
    expect(subject['henchmen'].last['last_name']).to eq('Stephenson')
    expect(subject['henchmen'].last.keys).to_not include(:loaction)
  end
end
