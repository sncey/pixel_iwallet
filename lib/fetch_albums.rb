require 'net/http'
require 'json'

class FetchAlbums
  JSONPLACEHOLDER_ALBUMS_URI = URI('https://jsonplaceholder.typicode.com/albums')
  JSONPLACEHOLDER_PHOTOS_URI = URI('https://jsonplaceholder.typicode.com/photos')

  def self.call
    albums_response = Net::HTTP.get(JSONPLACEHOLDER_ALBUMS_URI)
    photos_response = Net::HTTP.get(JSONPLACEHOLDER_PHOTOS_URI)
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
end
