MoviePolicy = Struct.new(:user, :movie) do
  def edit?
    !!(user && user.staff?)
  end

  def update?
    edit?
  end

  def submit?
    !!(user && (user.banned? == false))
  end

  def create?
    submit?
  end
end