class User < ApplicationRecord
  has_many :albums
  def photo_url
    "https://picsum.photos/id/#{self.id}/200/300"
  end
end
