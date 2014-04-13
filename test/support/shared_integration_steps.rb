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
    find('.alert.alert-success')
  end

  def logout
    visit(root_path)
    find('#user').click
    find('#logout').click
    find('.alert.alert-success')
  end
end