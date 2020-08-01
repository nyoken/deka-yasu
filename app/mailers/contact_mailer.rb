class ContactMailer < ApplicationMailer
  def send_email_to_user(contact)
    @contact = contact
    mail(to: @contact.email, subject: "【お問い合わせ完了のお知らせ】ペイつか")
  end

  def send_email_to_admin(contact)
    @contact = contact
    mail(to: ENV['MAIL_ADDRESS'], subject: "新規お問い合わせ")
  end
end
