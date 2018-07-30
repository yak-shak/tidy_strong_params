class OriginalGangsterSafeParams < TidyStrongParams::SafeParams
  attributes  :infamy,
              :fortune,
              :sentence,
              :time_served,
              henchmen: [:first_name, :last_name],
              cities: []
end