GameModePolicy = Struct.new(:user, :game_mode) do
  def moderate?
    user && user.admin?
  end

  def edit?
    moderate?
  end

  def update?
    moderate?
  end

  def destroy?
    moderate?
  end

  def create?
    moderate?
  end

  def new?
    moderate?
  end
end