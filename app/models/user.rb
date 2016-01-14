class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  validates :first_name, presence: true, length: {maximum: 25}
  validates :last_name, presence: true, length: {maximum: 25}

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  def self.find_for_google_oauth2(auth, signed_in_resource = nil)
    data = auth.info
    user = User.where(:email => data["email"]).first

     unless user
         user = User.create(first_name: data["first_name"],
            last_name: data["last_name"],
            email: data["email"],
            image: data["image"],
            password: Devise.friendly_token[0,20]
         )
     end
    user
  end



end
