class RawParameters
  def self.original_gangster_params
    ActionController::Parameters.new(
      original_gangster: {
        cities: %w[York London Lisbon],
        infamy: 8,
        henchmen: [
          { first_name: 'Bob', last_name: 'Bobson' },
          { first_name: 'Steve', last_name: 'Stephenson', location: 'Stevenage' }
        ],
        name: 'no allowed'
      }
     )
  end
end