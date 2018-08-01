require 'spec_helper'
require 'fixtures/params/original_gangster_strong_params'

RSpec.describe TidyStrongParams::Resource do
  let(:controller_class) { 'OriginalGangstersController' }
  subject { TidyStrongParams::Resource.new(controller_class: controller_class) }

  it 'returns a name' do
    expect(subject.name).to eq('original_gangster')
  end

  it 'returns a prams_method_name' do
    expect(subject.prams_method_name).to eq('original_gangster_params')
  end

  describe 'strong_params_class' do
    context 'resource with a params class' do
      it 'returns a strong_params_class' do
        expect(subject.strong_params_class).to eq(OriginalGangsterStrongParams)
      end
    end

    context 'resource without params class' do
      let(:controller_class) { 'NonExistantController' }

      it 'returns a strong_params_class' do
        expect(subject.strong_params_class).to eq(TidyStrongParams::StrongParams)
      end
    end
  end

  it 'params_class_name correct string' do
    expect(subject.send(:params_class_name)).to eq('OriginalGangster')
  end

  describe 'class methods' do
    describe 'self.prams_method_name' do
      it 'returns a prams_method_name' do
        expect(TidyStrongParams::Resource.prams_method_name(controller_class: controller_class)).to eq('original_gangster_params')
      end
    end
  end
end
