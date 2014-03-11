Tf2ClassPolicy = Struct.new(:user, :tf2_class) do
  def manage?
    user && user.admin?
  end

  def edit?
    manage?
  end

  def update?
    manage?
  end

  def destroy?
    manage?
  end

  def create?
    manage?
  end

  def new?
    manage?
  end
end