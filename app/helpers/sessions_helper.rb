module SessionsHelper

  def log_in(member)
    session[:member_id] = member.id
  end

  def current_member
    @current_member ||= Member.find_by(id: session[:member_id]) if session[:member_id]
  end

  def logged_in?
    !current_member.nil?
  end

  def log_out
    session.delete(:member_id)
	  @current_member = nil
  end

  def authenticate_member
    if !logged_in?
      redirect_to root_path
    end
  end

  def not_allow_to_enter_login
    if logged_in?
      redirect_to home_path(current_member)
    end
  end

  def is_joined
    topic = Topic.find(params[:id])
    room = Room.find(topic.room)
    member = current_member
    unless room.members.include?(member) or room.owner == member
      flash[:notice] = "You are not joined in this room"
      redirect_to home_path(member)
    end
  end
end