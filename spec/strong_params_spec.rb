require 'spec_helper'
require 'fixtures/params/original_gangster_strong_params'
require 'fixtures/params/original_gangster_with_required_strong_params'
require 'fixtures/params/original_gangster_without_required_strong_params'
require 'fixtures/params/original_gangster_with_tap_params_strong_params'
require 'fixtures/params/original_gangster_using_scope_strong_params'
require 'fixtures/params/original_gangster_with_own_params_method_strong_params'
require 'fixtures/raw_parameters.rb'

RSpec.describe TidyStrongParams::StrongParams do
  let(:raw_params) { RawParameters.original_gangster_params }
  let(:resource_name) { 'original_gangster' }
  subject { OriginalGangsterStrongParams.restrict(raw_params: raw_params, resource_name: resource_name) }

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

  describe '#required' do
    subject { OriginalGangsterWithRequiredStrongParams.restrict(raw_params: raw_params, resource_name: resource_name) }
    
    context "required param present" do
      let(:raw_params) { RawParameters.original_gangster_with_required_params }
      it "works" do
        expect(subject.keys).to eq(%w(infamy cities))
      end
    end

    context "required param missing" do
      let(:raw_params) { RawParameters.original_gangster_params }
      it "raises error" do
        expect{ subject }.to raise_exception(ActionController::ParameterMissing)
      end
    end

    context 'required param set to false' do
      subject { OriginalGangsterWithoutRequiredStrongParams.restrict(raw_params: raw_params, resource_name: resource_name) }
      let(:raw_params) { RawParameters.original_gangster_unnested_params }
      
      it "doesn't enforce a required param" do
        expect(subject.keys).to eq(%w(infamy cities))
      end
    end
  end

  describe '#tap_params' do
    subject { OriginalGangsterWithTapParamsStrongParams.restrict(raw_params: raw_params, resource_name: resource_name) }

    it "includes tap_params methods modifications" do
      expect(subject[:crazy_meta_param]).to eq(4)
    end
  end

  describe '#params' do
    subject { OriginalGangsterWithOwnParamsMethodStrongParams.restrict(raw_params: raw_params, resource_name: resource_name ) }

    it 'allows params method to be overridden' do
      expect(subject[:infamy]).to eq(8)
      expect(subject[:henchmen].first[:first_name]).to eq("Bob")
      expect(subject[:henchmen].first[:last_name]).to eq(nil)
    end
  end

  describe '#scope' do
    subject { OriginalGangsterUsingScopeStrongParams.restrict(raw_params: raw_params, resource_name: resource_name, scope: scope ) }

    context 'scope not defined' do
      let(:scope) { nil }

      it 'throws an error' do
        expect{ subject }.to raise_exception(NoMethodError)
      end
    end

    context 'scope defined' do
      let(:scope) { OpenStruct.new({ id: 1, type: 'user' }) }

      it 'utilizes the set scope' do
        expect{subject}.to_not raise_exception
      end

      it 'includes the scope dependant attribute' do
        expect(subject[:infamy]).to eq(8)
      end
    end
  end
end
