module ApplicationHelper
  def avatar_url(user)
    default_url = "#{root_url}images/manoutline.tn.png"
    default_url = "#{root_url}images/womanoutline.tn.png" if user.gender == "Female"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?d=#{CGI.escape(default_url)}"
  end

  def bible_ref(s)
    verses = Array.new 
    if s.index(",").nil? 
      verses << s
    else
      verses << s.split(",")
    end
    return verses
  end
end
