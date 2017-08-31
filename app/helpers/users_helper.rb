module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 150})
    size = options[:size]
    if user.avatar?
      image_tag(user.avatar.url, alt: user.name, class: "gravatar", size: size)
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
  end
end
