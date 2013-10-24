class Order < ActiveRecord::Base
  attr_accessible :city, :full_name, :order_status, :phone, :pin_code, :shipping_address, :state, :user_id, :stripe_card_token
  attr_accessor :stripe_card_token
  belongs_to :user
  has_many :orderdetails, dependent: :destroy 
  validates :full_name, :shipping_address, :phone, :state, :city, presence: true
  scope :delivered, where(:order_status => true)
  scope :un_delivered, where(:order_status => false)
  
  def save_with_payment
    if valid?
      begin
        customer = Stripe::Customer.create(description: self.user.email, card: stripe_card_token)
        self.stripe_customer_token = customer.id
        save!
      rescue 
        self.destroy
        false
      end 
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end
end

