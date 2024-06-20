# lib/fetch_albums.rb

require 'net/http'
require 'json'

# JSONPlaceholder endpoints
albums_uri = URI('https://jsonplaceholder.typicode.com/albums')
photos_uri = URI('https://jsonplaceholder.typicode.com/photos')

# HTTP GET requests
albums_response = Net::HTTP.get(albums_uri)
photos_response = Net::HTTP.get(photos_uri)

# Parse JSON responses
albums = JSON.parse(albums_response)
photos = JSON.parse(photos_response)

# Hash to store user IDs and corresponding albums
user_albums = Hash.new { |hash, key| hash[key] = [] }

# Group albums by user ID
albums.each do |album|
  user_albums[album['userId']] << album['id']
end

# Matching photos with albums
matched_albums = []

photos.each do |photo|
  if user_albums.any? { |_, album_ids| album_ids.include?(photo['albumId']) }
    matched_albums << photo
  end
end

# Output matched albums
matched_albums.each do |matched_album|
  puts "Album ID: #{matched_album['albumId']}, Photo Title: #{matched_album['title']}"
end
