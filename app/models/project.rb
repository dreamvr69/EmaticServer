class Project
  include Mongoid::Document
  extend Enumerize

  before_save :assign_franchise

  belongs_to :user
  has_many :visualisations, dependent: :destroy

  field :event_name
  field :client_name
  field :company_name
  field :client_phone
  field :client_email
  field :state

  STATE = [:confirmed, :booked, :framed]
  enumerize :state, in: STATE, default: :booked



  field :franchise_id, default: ""

  def assign_franchise
    if !User.find(user_id).nil?
      self.franchise_id = User.find(user_id).franchise_id
    end
  end

  def begin
    visualisations.min(:begin)
  end

  def end
    visualisations.max(:end)
  end

end
