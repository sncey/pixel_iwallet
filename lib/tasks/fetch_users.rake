namespace :json_placeholder do
  desc "Fetch users from JSONPlaceholder and store in the database"
  task fetch_users: :environment do
    users = JsonPlaceholderService.fetch_users

    users.each do |user_data|
      user = User.find_or_initialize_by(id: user_data['id'])
      user.update(
        name: user_data['name'],
        username: user_data['username'],
        email: user_data['email'],
        phone: user_data['phone'],
        website: user_data['website'],
        street: user_data.dig('address', 'street'),
        suite: user_data.dig('address', 'suite'),
        city: user_data.dig('address', 'city'),
        zipcode: user_data.dig('address', 'zipcode')
      )
    end

    puts "#{users.size} users fetched and stored in the database."
  end
end
