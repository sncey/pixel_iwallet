class Album < ApplicationRecord
  belongs_to :user
  has_many :photos

  require 'net/http'
  require 'json'

  albums_uri = URI('https://jsonplaceholder.typicode.com/albums')
  photos_uri = URI('https://jsonplaceholder.typicode.com/photos')

  albums_response = Net::HTTP.get(albums_uri)
  photos_response = Net::HTTP.get(photos_uri)

  albums = JSON.parse(albums_response)
  photos = JSON.parse(photos_response)

  user_albums = Hash.new { |hash, key| hash[key] = [] }

  albums.each do |album|
    user_albums[album['userId']] << album['id']
  end

  matched_albums = []

  photos.each do |photo|
    if user_albums.any? { |_, album_ids| album_ids.include?(photo['albumId']) }
      matched_albums << photo
    end
  end

  matched_albums.each do |matched_album|
    puts "Album ID: #{matched_album['albumId']}, Photo Title: #{matched_album['title']}"
  end
end
