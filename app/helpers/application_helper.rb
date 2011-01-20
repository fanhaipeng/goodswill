module ApplicationHelper
  def build_tab_bar(active_tab)
    return_text = ""
    [ 
      { :tab => :home, :url => home_index_path, :text => "Home" },
      { :tab => :introduction, :url => receiver_page_path(:page => "who_we_are"), :text => "Who we are" },
      { :tab => :donations, :url => donation_query_path, :text => "How you can help" },
      { :tab => :news, :url => news_index_path, :text => "News" },
      { :tab => :admin, :url => deliveries_path, :text => "Admin" }
    ].map do |v| 
      if (not session[:user_id]) and v[:tab] == :admin
        next;
      end

      if active_tab == v[:tab]
        return_text << raw( "<li class=\"active_tab\">#{link_to v[:text], v[:url]}</li>")
      else
        return_text << raw("<li>#{link_to v[:text], v[:url]}</li>")
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
