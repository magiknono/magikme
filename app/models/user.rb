class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  validates :name, presence: true, length: {maximum: 25}

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  def self.find_for_google_oauth2(auth, signed_in_resource = nil)
    data = auth.info
    user = User.where(:email => data["email"]).first

     unless user
         user = User.create(name: data["name"],
            email: data["email"],
            password: Devise.friendly_token[0,20]
         )
     end
    user
  end



end
