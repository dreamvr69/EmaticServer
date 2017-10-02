class User
  include Mongoid::Document
  include Mongoid::Timestamps
  extend Enumerize
  devise :database_authenticatable, :trackable

  SEXES = [:male, :female]

  before_save   :ensure_authentication_token
  before_save :set_default_role

  #field :quick_save_id

  ## Database authenticatable
  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  field :auth_date,          type: DateTime

  field :name
  field :mobile
  field :authentication_token

  field :user_role, type: String, default: 'manager'

  #Зависимости для Terminal
  has_many                :projects, class_name: "Project", :dependent => :destroy
  belongs_to  :franchise, optional: true
  has_many :notes
  has_many :visualisations

  # def create_card
  #   if self.franchise.present?
  #     Card.create(franchise: self.franchise, user: self)
  #   end
  # end

  def assign_default_role

    # Блок дял нового сервера
    if user_role.empty?
      user_role = 'manager'
    end
  end

  def set_default_role
    if user_role.empty?
      self.user_role = 'manager'
    end
  end

  def login=(login)
    @login = login
  end

  def login
    if self.mobile.present?
      self.mobile
    else
      self.email
    end
  end

  def is_client
    (self.roles.size == 1) && (self.has_role? :client)
  end

  def is_owner
    self.has_role? :fitclubs_administrator
  end

  def is_admin
    # self.has_role? :franchise_administrator
    true
  end

  def is_super_user?
    user_role == 'super_user'
  end

  def is_franshise_admin?
    user_role == 'franchise_administrator'
  end

  def can_read_owned_by_user?(user_id)
    if is_super_user?
      return true
    elsif is_franshise_admin? && User.find(user_id).franchise_id==franchise_id
      return true
    else
      return (BSON::ObjectId.from_string(user_id) == _id)
    end
  end

  def can_write_owned_by_user?(user_id)
    is_super_user? || user_id == _id.toString()
  end

  def can_read_owned_by_franchise?(franchise_id)
    is_super_user || (is_franchise_admin? && franchise_id == self.franchise_id)
  end

  def can_create_project?(franchise_id)
    is_super_user || franchise_id == self.franchise_id
  end

  def quick_save(visualisation)
    self.quick_save_id = "f6"
  end


  private
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
