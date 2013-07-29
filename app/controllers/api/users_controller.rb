class Api::UsersController < ApplicationController

  respond_to :html, :json, :xml

	def sign_in
    user = Member.find_by_email(params[:email])
    if is_valid_user_password(user, params[:password])
      user.ensure_authentication_token!
      respond_success("access_token" => user.authentication_token,
      :name => user.username,
      :uid => user.id)
    else
      respond_error(params[:type], "Invalid username or password")
    end
  end

  def user_register
    rv = Member.new(params[:member])
    if rv.save
      respond_success(:notice=>"You must activate you registered on email #{rv.email}")
      return
    else
      error = "User can't created"
      error = rv.errors.full_messages if rv.errors.full_messages.present?
      respond_error(params[:type], error)
      return
    end
  end

  def change_password
    user = Member.find_by_id_and_name(params[:uid], params[:name].downcase)
    if user.present?
      if is_valid_user_password(user, params[:oldpassword])
        if user.update_attribute(:password, params[:new_password])
          respond_success()
        else
          respond_error(params[:type], "Update data is failed")
        end
      else
        respond_error(params[:type], "No match old password")
      end
    else
      respond_error(params[:type], "User not found")
    end
  end

  def sign_out
    sign_out(resource_name)
  end

  private

  # Json for successfully to return data
  def respond_success(options={})
    options.merge!(:success => 1, :type => params[:type])
    render :json => options.as_json
  end

  # Json for unsuccessfully to return data
  def respond_error(type, message, options={})
    render :json => options.merge!(:failed => 0,:type => type,:message => message).as_json
  end

  def is_valid_user_password(user, ppassword)
    data = false
    if user.present?
      data = true if user.valid_password?(ppassword)
    end
    return data
  end

end
