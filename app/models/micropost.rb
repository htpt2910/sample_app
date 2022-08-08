class Micropost < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :content, presence: true,
                      length: {maximum: Settings.post.max_content_length}
  validates :image,
            content_type: {in: Settings.post.image_type,
                           message: :image_format},
                            size: {less_than: Settings.post.size.megabytes,
                                   message: :image_size}

  scope :recents, ->{order(created_at: :desc)}

  delegate :name, to: :user, prefix: true

  def display_image
    image.variant resize_to_limit: Settings.post.image_resize
  end
end
