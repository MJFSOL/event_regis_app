namespace :my_tasks do
  desc "Promotes a user to an admin role"
  task :promote_user_to_admin, [ :email ] => :environment do |t, args|
    email = args[:email]
    if email.blank?
      puts "Please provide an email address. Example: rake my_tasks:promote_user_to_admin[user@example.com]"
      exit
    end

    user = User.find_by(email: email)
    if user
      user.admin!
      puts "User #{user.email} has been promoted to admin."
    else
      puts "User with email #{email} not found."
    end
  end
end
