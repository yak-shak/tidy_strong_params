require 'fixtures/controllers/original_gangsters_controller'
require 'fixtures/params/original_gangster_strong_params'
require 'fixtures/raw_parameters'

RSpec.describe TidyStrongParams do
  it 'has a version number' do
    expect(TidyStrongParams::VERSION).not_to be nil
  end

  it 'passes smoke test' do
    expected_params = {
      "infamy"=>8,
      "henchmen"=>[
        { 
          "first_name"=>"Bob",
          "last_name"=>"Bobson"
        },
        { "first_name"=>"Steve",
          "last_name"=>"Stephenson"}
      ], 
      "cities"=>["York", "London", "Lisbon"]
    }
    expect(OriginalGangstersController.new.tidy_params).to eq(expected_params)
  end
end
