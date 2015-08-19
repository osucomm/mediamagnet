class AdminConstraint
  def matches?(request)
    current_user = User.find_by(id: request.session[:user_id])
    current_user && current_user.admin?
  end
end
