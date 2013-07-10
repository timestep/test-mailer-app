class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
  	@user = user
  	@url = 'http://example.com/login'
  	mail(to: @user.email, 
  		subject: 'Welcome to This Shit',
  		template_path: 'notifications',
  		template_name: 'another')
  end
  
	def receive(email)
    page = Page.find_by(address: email.to.first)
    page.emails.create(
      subject: email.subject,
      body: email.body
    )
 
    if email.has_attachments?
      email.attachments.each do |attachment|
        page.attachments.create({
          file: attachment,
          description: email.subject
        })
      end
    end
  end

end
