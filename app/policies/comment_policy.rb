CommentPolicy = Struct.new(:user, :comment) do
  def new?
    !!(user && (user.banned? == false))
  end

  def create?
    new?
  end
end
