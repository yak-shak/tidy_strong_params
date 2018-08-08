class OriginalGangsterWithTapParamsStrongParams < TidyStrongParams::StrongParams
  params :infamy,
         :fortune,
         :sentence,
         :time_served,
         henchmen: %i[first_name last_name],
         cities: []

  def tap_params(whitelist)
    whitelist[:crazy_meta_param] = raw_params[:original_gangster].keys.length
  end
end
