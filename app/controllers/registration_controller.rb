class RegistrationController < ApplicationController

  def new

    @member= Member.new
    @contact = Contact.new
  end

  def create

    @member = Member.new(params[:member])
    
    @contact = Contact.new(params[:contact])
    
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
