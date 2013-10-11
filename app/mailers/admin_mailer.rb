class AdminMailer < ActionMailer::Base
  default from: "onlineshopping@grepruby.com"
  
  def admin_email(user,sub,body)
    @user = user
    @sub=sub
    @body=body
    mail(to: @user.email, subject:@sub).deliver
  end
  
  def order_placed_email(user,order)
    @user = user
    @order=order
    mail(to: @user.email, subject:"Order placed successfully").deliver
  end
  
end
