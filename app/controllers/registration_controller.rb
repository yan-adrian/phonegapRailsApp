class RegistrationController < ApplicationController

  def new

    @member= Member.new
    @contact = Contact.new
  end

  def create

    @member = Member.new
    @member.username = params[:member][:username]
    @member.email = params[:member][:email]
    @member.password = params[:member][:password]
    @member.password_confirmation =params[:member][:password_confirmation]

    @contact = Contact.new
    @contact.mobile = params[:contact][:mobile]
    @contact.address = params[:contact][:address]
    @member.valid?
    
    if @member.errors.blank?

      @member.save
      @contact.member = @member
      @contact.save
      redirect_to dashboard_path
    else
      render :action => "new"
    end
  end

end
