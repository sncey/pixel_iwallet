class JsonPlaceholderService
  include HTTParty
  base_uri 'https://jsonplaceholder.typicode.com'

  def self.fetch_users
    response = get('/users')
    if response.success?
      response.parsed_response.each do |user_data|
        User.create!(
          name: user_data['name'],
          username: user_data['username'],
          email: user_data['email'],
          street: user_data['address']['street'],
          suite: user_data['address']['suite'],
          city: user_data['address']['city'],
          zipcode: user_data['address']['zipcode'],
          phone: user_data['phone'],
          website: user_data['website']
        )
      end
    else
      raise "Error fetching users: #{response.code}"
    end
  end
end
