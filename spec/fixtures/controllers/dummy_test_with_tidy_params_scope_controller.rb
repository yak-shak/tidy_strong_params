class DummyTestWithTidyParamsScopeController < ActionController::Base
  tidy_params_scope :current_user

  def current_user
    { id: 'fake_id' }
  end
end
