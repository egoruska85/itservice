class Contact < MailForm::Base
  attribute :name, validate: true
  validates :name, presence: true, length: {minimum: 2}




  attribute :email, validate: /\A[^@\s]+@[^@\s]+\z/i
  attribute :file, attachment: true
  attribute :sender, validate: /\A[^@\s]+@[^@\s]+\z/i
  attribute :phone
  validates :phone, :presence => {:message => 'hello world, bad operation!'},
                    :numericality => true,
                    :length => { :minimum => 12, :maximum => 12 }

  attribute :message
  attribute :nickname, captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: "Сообшение от сайта ITMASTER33",
      to: "egorarbuzov@gmail.com",
      from: %("#{name}" <#{sender}>)
    }
  end
end
