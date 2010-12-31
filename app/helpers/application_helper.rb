module ApplicationHelper
  def build_tab_bar(active_tab)
    return_text = ""
    { 
      :home => { :url => home_index_path, :text => "Home" },
      :introduction => { :url => "", :text => "Introduction" },
      :donations => { :url => donation_query_path, :text => "Donations" },
      :receivers => { :url => receivers_path, :text => "Receivers" },
      :news => { :url => news_index_path, :text => "News" },
      :admin => { :url => deliveries_path, :text => "Admin" }
    }.each_pair do |k, v| 
      if (not session[:user_id]) and k == :admin
        next;
      end

      if active_tab == k
        return_text << raw( "<li class=\"active_tab\">#{v[:text]}</li>")
      else
        return_text << raw("<li class=\"normal_tab\">#{link_to v[:text], v[:url]}</li>")
      end
    end
    raw return_text
  end

  def authenticated
    session[:user_id]
  end

  def generate_login_link
    out = ""
    if authenticated
      user = User.find_by_id(session[:user_id])
      out << "Welcome "
      out << link_to(user.name, user_path(user))
      out << " ["
      out << link_to("logout", account_logout_path) 
      out << "]"
    else
      out << link_to("login", account_login_path)
    end
    raw out
  end
end
