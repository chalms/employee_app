class TaskSerializer < ApplicationSerializer
  has_many :reports_tasks
  has_many :users_reports, :through => :reports_tasks
  has_many :reports, :through => :users_reports
  has_many :projects, :through => :reports
  attributes :name, :description, :manager_id, :assignment, :owners

end
