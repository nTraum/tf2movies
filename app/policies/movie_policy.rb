MoviePolicy = Struct.new(:user, :movie) do
  def edit?
    user && user.moderator_or_admin?
  end

  def update?
    edit?
  end

  def submit?
    user && user.banned? == false
  end
end