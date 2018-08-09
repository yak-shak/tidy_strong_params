class OriginalGangsterUsingScopeStrongParams < TidyStrongParams::StrongParams
  def params
    [ infamy,
      :fortune
    ]
  end

  def infamy
    :infamy if scope.type == 'user'
  end
end
