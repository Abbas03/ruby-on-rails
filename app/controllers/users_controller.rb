def update
  message = false

  user = User.where("id = '#{params[:user][:id]}'")[0]

  if user
    user.update_attributes(user_params_without_password)
    User.first(:conditions => "username = '#{params[:username]}'")
    if params[:user][:password].present? && (params[:user][:password] == params[:user][:password_confirmation])
      user.password = params[:user][:password]
    end
    message = true if user.save!
    respond_to do |format|
      format.html { redirect_to user_account_settings_path(user_id: current_user.id) }
      format.json { render json: {msg: message ? "success" : "false "} }
    end
  else
    flash[:error] = "Could not update user!"
    redirect_to user_account_settings_path(user_id: current_user.id)
  end
end