#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :trackable, :omniauthable,
         omniauth_providers: [:google_oauth2]

  has_many :posts
  has_many :roles
  has_many :scores

  has_many :enrollments, foreign_key: 'student_id'
  has_many :sections, through: :enrollments
  has_many :assessments, through: :sections

  validates :given_name, presence: true
  validates :family_name, presence: true
  validates :email, presence: true

  # XXX - what happens if validation fails on first login
  # TODO: validate e-mail (should be a district address, g.highlineschools.org)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      # user.name = auth.info.name # assuming the user model has a name
      name = auth.info.name.split(nil, 2)
      unless name.count == 1
        user.given_name = name[0]
        user.family_name = name[1]
      else
        # In honor of Fureigh.
        user.given_name = ""
        user.family_name = name[0]
      end
      user.check_name = auth.info.name.split(nil).count > 2 ? true : false
      # TODO: set role
      # TODO: if student set student_id
    end
  end

  def name
    # TODO: support preferred_name
    unless given_name == ""  # Fureigh
      "#{preferred_name ? preferred_name : given_name} #{family_name}"
    else
      family_name
    end
  end

  # Predicates for user activity.
  def active_today?
    self.last_active_time&.today?
  end

  # Black magic to automagically create a <ROLENAME>? function for each role.
  Role::NAMES.each do |rolename|
    define_method "#{rolename}?" do
      roles.where(role: rolename).any?
    end
  end
end
