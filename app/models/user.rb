class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
   
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :phone, :password, :country, :state, :city, :address, :is_admin, :confirmed_at
  attr_accessible :provider, :uid, :name
  validates :first_name, presence: true
  has_many :pictures, as: :imageable
  has_many :orders, dependent: :destroy
  has_many :cart, dependent: :destroy
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(first_name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20],
                         :confirmed_at => DateTime.now
                         )
    end
    user
  end
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    unless user
      user = User.create(first_name: data["name"],
             email: data["email"],
             password: Devise.friendly_token[0,20],
             :confirmed_at => DateTime.now
            )
    end
    user
  end
  
end
