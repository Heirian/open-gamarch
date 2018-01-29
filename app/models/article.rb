class Article < ApplicationRecord
  include ActionView::Helpers::TextHelper
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 10000 }

  belongs_to :user
  validates :user_id, presence: true

  default_scope -> { order(created_at: :desc) }

  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader
  validate :image_size

  def word_count
     self.description.split.size
  end

  def reading_time
     (word_count / 180.0).ceil
  end

  def timestamp
    month = created_at.strftime("%B")
    tmonth = I18n.t "#{month}"
    created_at.strftime("#{tmonth} %d, %Y #{I18n.t 'at'} %H:%M")
  end

  def timestamp_dmy
    month = created_at.strftime("%B")
    tmonth = I18n.t "#{month}"
    created_at.strftime("%d #{tmonth} %Y #{I18n.t 'at'} %H:%M")
  end

  def make_safe(size)
    simple_format(description.gsub(/^(.{#{size},}?).*$/m,'\1...'))
  end

  private

  # Validates the size of an uploaded image.
  def image_size
    if image.size > 100.kilobytes
      errors.add(I18n.t(:image), "#{I18n.t(:size_cover)} #{I18n.t(:cover_size_after_resize)} 100KB")
    end
  end

end
