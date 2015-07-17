module SubsHelper
  def is_moderator?(sub)
    current_user == sub.moderator
  end
end
