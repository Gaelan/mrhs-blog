#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :trackable, :omniauthable,
         omniauth_providers: [:google_oauth2]

  has_many :posts
  has_many :enrollments, foreign_key: 'student_id'
  has_many :sections, through: :enrollments
  has_many :roles

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.name = auth.info.name   # assuming the user model has a name
    end
  end

  # Tests on user activity.
  def active_today?
    'success'
    # 'danger' 'warning'
  end

  # Black magic to automagically create a <ROLENAME>? function for each role.
  Role::NAMES.each do |rolename|
    define_method "#{rolename}?" do
      roles.where(role: rolename).any?
    end
  end
end
