crumb :root do
  link fa_icon('home'), root_path
end

crumb :movies do
  link 'Movies', movies_path
end

crumb :submit do
  link 'Submission'
  parent :movies
end

crumb :movie do |movie|
  link movie.title, movie
  parent :movies
end

crumb :manage_movies do
  link 'Manage', manage_movies_path
  parent :movies
end

crumb :edit_movie do |movie|
  link 'Edit'
  parent :manage_movies
end

crumb :users do
  link 'Users', users_path
end

crumb :user do |user|
  link user.nickname, user
  parent :users
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).