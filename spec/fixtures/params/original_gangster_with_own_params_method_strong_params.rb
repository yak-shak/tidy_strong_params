class OriginalGangsterWithOwnParamsMethodStrongParams < TidyStrongParams::StrongParams
  def params
    [
      :infamy,
      henchmen
    ]
  end

  def henchmen
    { henchmen: %i(first_name) }
  end
end
