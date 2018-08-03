class OriginalGangstersController < ActionController::Base
  def params
    RawParameters.original_gangster_params
  end
end