ActionMailer::Base.smtp_settings = {
:address => "smtp.gmail.com",
:port => 587,
:domain => "mail.google.com",
:user_name => "onlineshoppinggr@gmail.com",
:password => "shakti1234567890",
:authentication => :login,
:enable_starttls_auto => true
}
