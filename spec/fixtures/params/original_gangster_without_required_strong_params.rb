class OriginalGangsterWithoutRequiredStrongParams < TidyStrongParams::StrongParams
  required false
  params :infamy,
         :fortune,
         :sentence,
         :time_served,
         henchmen: %i[first_name last_name],
         cities: []
end
