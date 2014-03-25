CommentPolicy = Struct.new(:user, :comment) do
  def new?
    !!(user && (user.banned == false))
  end

  def edit?
    !!(user && (comment.user == user))
  end

  def update?
    !!(edit? || user.staff?)
  end

  def create?
    new?
  end
end