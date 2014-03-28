MoviePolicy = Struct.new(:user, :movie) do
  def manage?
    !!(user && user.staff?)
  end
  def edit?
    manage?
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