class Contact < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :phone, :email, :name, :owner, :id, :client_id, :company_id, :user_id
  belongs_to :company
  belongs_to :user
  validate :validator

  def to_json
    return self.as_json({
      only: [:name, :email, :phone, :id]
      })
  end

  def validator
    if (company || user)
      return true
    else
      raise Exceptions::StdError, "Contact has no owner"
      return false
    end
  end

  def owner=(own)
    if ((own.is_a? Company) || (own.is_a? User))
      @owner = own
    end
  end

  def owner
    @owner ||= (company || user)
  end
end