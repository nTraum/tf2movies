GameModePolicy = Struct.new(:user, :game_mode) do
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