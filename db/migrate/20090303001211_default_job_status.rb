class DefaultJobStatus < ActiveRecord::Migration
  def self.up
    change_column_default :job, :job_status_type_id, 1
  end

  def self.down
    #do nothing.
  end
end
