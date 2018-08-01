class OriginalGangsterStrongParams < TidyStrongParams::StrongParams
  attributes  :infamy,
              :fortune,
              :sentence,
              :time_served,
              henchmen: [:first_name, :last_name],
              cities: []
end