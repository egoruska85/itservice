RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.authorize_with do
    # 1. Сначала требуем, чтобы пользователь вошел в систему

    # 2. Если в базе всего 1 пользователь — пускаем его
    is_only_user = (User.count == 1)

    # 3. Если он не единственный и при этом не админ — выкидываем
    unless is_only_user || warden.user.admin?
      redirect_to main_app.root_path, alert: "Доступ запрещен!"
    end
  end

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
