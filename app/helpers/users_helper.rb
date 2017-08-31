module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 150, class: 'gravatar' })
    size = options[:size]
    img_class = options[:class]
    if user.avatar?
      image_tag(user.avatar.url, alt: user.name, class: img_class, size: size)
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      image_tag(gravatar_url, size: size, class: img_class, alt: user.name)
    end
  end
end
