class SignupMailer < ApplicationMailer
    def test_mail()
         mail(to: "stevendaryl3016@yahoo.com", subject: "Testing")
    end
    
    def test_mail3()
        mail(to: "stevendaryl3016@yahoo.com", subject: "Testing3", template_path: ["signup_mailer"], template_name: "test_mail")
    end
    
    def test_mail4()
        hash = {to: "stevendaryl3016@yahoo.com", subject: "Testing4", template_path: ["signup_mailer"], template_name: "test_mail"}
        mail(hash)
    end
    
    def test5(hash)
        mail(hash)
    end
end
