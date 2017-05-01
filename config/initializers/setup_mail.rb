  if Rails.env.development? || Rails.env.production?
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address:        'smtp.sendgrid.net',
      port:           '2525',
      authentication: :plain,
      user_name:      ENV['SENDGRID_USERNAME'],
      password:       ENV['SENDGRID_PASSWORD'],
      #domain:         'heroku.com',
      domain:          "sendgrid.com",
      enable_starttls_auto: true
    }

    #class Devise::Mailer < Devise.parent_mailer.constantize
    #  old_devise_mail = instance_method(:devise_mail)
    #  
    #  define_method(:devise_mail) do |record, action, opts, &block|
    #    puts "Hey!"
    #    old_devise_mail.bind(self).(record, action, opts, &block)
    #  end
    #  
    #end
    
    #class ActionMailer::Base
    #  old_mail = instance_method(:mail)
    #  
    #  define_method(:mail) do |opts|
    #    puts "<---Hey"
    #    puts opts
    #    puts "Hey--->"
    #    old_mail.bind(self).(opts)
    #  end
    #end
    
    #ActionMailer::Base.mail(subject: "Test", to: "stevendaryl3016@yahoo.com", template_path: ["signup_mailer"], template_name: "test_mail", from: "stevendaryl3016@yahoo.com").deliver_now
    #SignupMailer.test_mail.deliver_now
    #SignupMailer.test_mail1.deliver_now
    #ActionMailer::Base.layout 'mailer'
    ActionMailer::Base.default from: "stevendaryl3016@example.com"
    
    #ActionMailer::Base.mail(subject: "Yet Another Test", to: "stevendaryl3016@yahoo.com", template_path: ["signup_mailer"], template_name: "test_mail", from: "stevendaryl3016@yahoo.com").deliver_now


    
  end