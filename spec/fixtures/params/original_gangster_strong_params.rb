class OriginalGangsterStrongParams < TidyStrongParams::StrongParams
  attributes  :infamy,
              :fortune,
              :sentence,
              :time_served,
              henchmen: %i[first_name last_name],
              cities: []
end
