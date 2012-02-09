require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
  end

  def test_random_password
    (0..30).each do 
      assert User.random_password.length == AppConfig['new_password_length']
    end
  end
end
