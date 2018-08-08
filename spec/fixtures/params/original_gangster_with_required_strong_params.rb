class OriginalGangsterWithRequiredStrongParams < TidyStrongParams::StrongParams
  required    :imitation_gangster
  params :infamy,
         :fortune,
         :sentence,
         :time_served,
         henchmen: %i[first_name last_name],
         cities: []
end
