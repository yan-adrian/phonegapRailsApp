class SmsController < ApplicationController

  require 'socket'

  def new;end

  def create
    nexmoSendSms
  end

private

  def nexmoSendSms
    response = SendSMS.perform_async(params[:recipient], "RAILS", params[:message_text])
    flash[:notice] = response ? "Message sent succesfully!" : "Error!"
    redirect_to :back
    rescue SocketError => e
      flash[:notice] = "Check your internet connection: #{e.message}"
      redirect_to :back
  end

  def clickatell
    sms = SMS.new(CLICKATELL_CONFIG)
    sms.create(params[:recipient], params[:message_text])
    flash[:notice] = "Message sent succesfully!"
    redirect_to :back
    rescue Clickatell::API::Error => e
      flash[:error] = "Clickatell API error: #{e.message}"
      redirect_to :back
  end

end