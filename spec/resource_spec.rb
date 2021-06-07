require 'spec_helper'
require 'fixtures/params/original_gangster_strong_params'
require 'fixtures/params/example_module/example_strong_params'

RSpec.describe TidyStrongParams::Resource do
  let(:controller_class) { 'OriginalGangstersController' }
  subject { TidyStrongParams::Resource.new(controller_class: controller_class) }

  it 'returns a name' do
    expect(subject.name).to eq('original_gangster')
  end

  context 'with a nested module' do
    let(:controller_class) { 'ExampleModule::ExamplesController' }
    it 'returns a non-nested name' do
      expect(subject.name).to eq('example')
    end
  end

  describe '#strong_params_class' do
    context 'resource with a params class' do
      it 'returns a strong_params_class' do
        expect(subject.strong_params_class).to eq(OriginalGangsterStrongParams)
      end
    end

    context 'resource without params class' do
      let(:controller_class) { 'NonExistantController' }

      it 'raises params class not defined error' do
        exception = TidyStrongParams::Errors::StrongParamsClassUndefinedError
        expect{ subject.strong_params_class }.to raise_exception(exception)
      end
    end
  end

  it 'params_class_name correct string' do
    expect(subject.send(:params_class_name)).to eq('OriginalGangsterStrongParams')
  end
end
