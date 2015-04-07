class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    auth = request.env['omniauth.auth']
    # Find an identity here
    @identity = Identity.find_with_omniauth(auth)

    if @identity.nil?
      # If no identity was found, create a brand new one here
      @identity = Identity.create_with_omniauth(auth)
    end

    if user_signed_in?
      if @identity.user == current_user
        # User is signed in so they are trying to link an identity with their
        # account. But we found the identity and the user associated with it 
        # is the current user. So the identity is already associated with 
        # this user. So let's display an error message.
        flash[:alert] = "This account has already been linked."
      else
        # The identity is not associated with the current_user so lets 
        # associate the identity
        @identity.user = current_user
        @identity.save
        flash[:notice] = "Successfully linked #{titleize(@identity.provider)} account: #{@identity.uid}"
      end
    else
      unless @identity.user.present?
        # No user associated with the identity so we need to create a new one
        @identity.user = User.create_with_omniauth(auth['info'])
        @identity.save
      end

      # Log in the user
      self.current_user = @identity.user
      @identity.user.sign_in!
      show_welcome_message
    end

    redirect_to_origin
  end

  def failure
    error_message = "There was an error during your login attempt."
    error_message = params[:message].nil? ? error_message : error_message += " The error was: #{params[:message].humanize}"
    flash[:error] = error_message
    redirect_to root_url
  end

  def destroy
    self.current_user = nil
    redirect_to root_url, notice: "You have been logged out. Come back soon!"
  end


  private

  def redirect_to_origin
    redirect_to request.env['omniauth.origin'] || session.delete(:return_to) || root_url
  end

  def show_welcome_message
    if current_user.sign_in_count == 1 || (current_user.sign_in_count <= 5 && current_user.entities.count == 0)
      flash[:welcome] = render_to_string(partial: 'sessions/welcome_message', layout: false)
    end
  end
end
