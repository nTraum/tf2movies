module SharedIntegrationSteps
  def login
    # Omniauth mock
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:steam] = OmniAuth::AuthHash.new(
      :provider => 'steam',
      :info => {
        :nickname => 'Bob',
        :urls => { :Profile => 'http://steamcommunity.com/12345' }
        },
      :uid => '12345'
    )

    visit(root_path)
    click_link('login')
    find_flash(:notice)
  end

  def logout
    visit(root_path)
    find('#user').click
    find('#logout').click
    find_flash(:notice)
  end

  def find_flash(type)
    raise ArgumentError unless [:notice, :warning, :alert].include?(type)
    within('main') do
      if type == :notice
        find('.alert.alert-success.alert-dismissable')
      elsif type == :warning
        find('.alert.alert-warning.alert-dismissable')
      elsif type == :alert
        find('.alert.alert-danger.alert-dismissable')
      end
    end
  end
end