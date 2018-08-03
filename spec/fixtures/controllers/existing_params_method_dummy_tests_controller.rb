class ExistingParamsMethodDummyTestsController < ActionController::Base
  def tidy_params
    { existing_method: true }
  end
end
