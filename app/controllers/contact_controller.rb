# frozen_string_literal: true

class ContactController < ApplicationController
  before_action :set_contact, only: %i[confirm create]

  def new
    @contact = Contact.new
  end

  def confirm; end

  def create
    if @contact.save
      ContactMailer.send_email_to_user(@contact).deliver
      ContactMailer.send_email_to_admin(@contact).deliver
      render :complete
    else
      flash.now[:danger] = 'エラーが発生したためもう一度入力してください。'
      render :new
    end
  end

  def complete; end

  private

  def contact_params
    params.require(:contact).permit(:name, :tel, :email, :content)
  end

  def set_contact
    @contact = Contact.new(contact_params)
  end
end
