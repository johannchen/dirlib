module ApplicationHelper
  def avatar_url(user)
    default_url = "#{root_url}images/guest.png"
    default_url = "#{root_url}images/female.png" if user.gender == "Female"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?d=#{CGI.escape(default_url)}"
  end
end
