require 'test_helper'

class JobTest < ActiveSupport::TestCase
  fixtures :process_type
  def setup
    load_user
    @j = Job.new
    @j.account = broker_account(:default)
    @j.user = broker_user(:authorized_user)
    @j.process_type = process_type(:processing_job)
  end

  def test_default_task_class_id_is_three
    @j.task_class_id = nil
    @j.save!
    @j.reload
    assert_equal 3, @j.task_class_id
  end

  def test_saving_with_process_type_id
    @j.task_class_id=1   
    @j.save!
    @j.reload
    assert_equal 1, @j.task_class_id
  end
end
