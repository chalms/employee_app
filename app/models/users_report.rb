class UsersReport < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :complete, :checkin, :checkout, :parts, :tasks, :date, :hours, :employee, :manager, :report_id, :user_id, :chat_id, :checkout_location, :checkin_location
  belongs_to :report
  belongs_to :user
  has_many :reports_parts
  has_many :reports_tasks
  has_one :chat
  has_many :locations


  after_create :create_chat
  TYPES = ['UsersReportsChat', 'ReportsChat']

  def to_json
    self.as_json({
      only: [:complete, :checkin, :checkout, :report_id, :user_id, :chat_id],
      methods: [:date_json, :manager_json],
      include: :reports_tasks
    }).to_json
  end

  def checkin_location
    l = Location.where(:users_reports_id => self.id).andand.first
    if (!l.present?)
      return
    end
    l.order('created_at DESC').first
  end

  def create_chat
    chat = Chat.joins(:users_chats).where('user_id = ? OR user_id = ?', user.id, manager_id)
    if (chat)
      if chat.empty?
        puts "creating chat"
        chat = UsersReportsChat.create!({:type => TYPES[0], :users_report_id => self.id, :name => "#{employee.name} & #{manager.name}"})
        employee.users_chats.where({:chat_id => chat.id}).first_or_create!
        chat.users_chats.create!({:user_id => employee.id})
        manager.users_chats.where({:chat_id => chat.id}).first_or_create!
        chat.users_chats.create!({:user_id => manager.id})
      else
        chat = chat.first
      end
    else
      update_attribute(:chat_id, chat.id)
    end
    manager.users_chats.where(:chat_id => chat.id).first_or_create
  end

  def data_json
    {:date => date}.as_json
  end

  def manager_json
    return manager.as_json({
      only: [:name, :email, :employee_number, :id]
    })
  end

  def get_report
    @report = Report.where(id: report_id).first
    unless @report
      destroy_me!
    end
  end

  def destroy_me!
    reports_tasks.each do |rt|
      rt.destroy
    end
    reports_parts.each do |rt|
      rt.destroy
    end
    destroy
  end

  def date
    get_report.andand.date
  end

  def manager

    @manager ||= User.find(report.user.id)
    if (@manager.present?)
      raise Exceptions::StdError, "User report cant find manager!" if (@manager.role == 'employee')
    end
    @manager
  end

  def employee
    @employee ||= self.user
    @employee ||= User.find(self.user_id)
    @employee
  end

  def hours
    @hours = 0
    return @hours unless (checkin.present? && checkout.present?)
    @hours = (checkin - checkout)/1.hour
  end

  def parts
    reports_parts.map { |q| q.part }
  end

  def tasks
    reports_tasks.map { |q| q.task }
  end

  def add_reports_task(reports_task)
    reports_tasks.where(id: reports_tasks.id).first_or_create
  end

  def add_reports_part(reports_part)
    reports_parts.where(id: reports_parts.id).first_or_create
  end

  def assigned_tasks(options = {})
    reports_tasks
  end

  def complete_tasks(options = {})
    reports_tasks.where(:complete, true)
  end

  def add_task(task_id)
    return reports_tasks.where(task_id: task_id).first_or_create
  end

  def add_part(part_id)
    return reports_parts.where(part_id: part_id).first_or_create
  end

  def incomplete_parts
    return reports_parts.where(:complete => false)
  end

  def incomplete_tasks
    return reports_tasks.where(:complete => false)
  end

  def completed_parts
    return reports_parts.where(:complete => true)
  end

  def completed_tasks
    return reports_tasks.where(:complete => true)
  end

  def self.complete?
    @complete ||= if (reports_parts.where(:complete => false) && reports_tasks.where(:complete => false))
        false
      else
        self.update_attributes(:complete => true)
        true
      end
  end
end