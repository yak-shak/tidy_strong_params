require "spec_helper"
require "fixtures/controllers/dummy_tests_controller"
require "fixtures/controllers/existing_params_method_dummy_tests_controller"


RSpec.describe TidyStrongParams::Controller do
  context "controller without existing params method" do
    it "sets params method" do
      expect(DummyTestsController.new).to respond_to(:dummy_test_params) 
    end

    it "sets loads param method from Gem" do
      m = DummyTestsController.new.method(:dummy_test_params)
      expect(m.source_location.first).to match("tidy_strong_params/controller.rb")
    end
  end

  context "controller with existing params method" do
    it "skips setting params method" do
      controller = ExistingParamsMethodDummyTestsController.new
      expect(controller.existing_params_method_dummy_test_params).to eq({ existing_method: true }) 
    end

    it "keeps the classes original method" do
      m = ExistingParamsMethodDummyTestsController.new.method(:existing_params_method_dummy_test_params)
      expect(m.source_location.first).to match("existing_params_method_dummy_tests_controller.rb")
    end
  end
end