module DonationsHelper
  def remove_link_unless_new_record(fields, classname)
    unless fields.object.new_record?
      out = ''
      out << fields.hidden_field('_destroy')
      out << link_to_function("remove", "$(this).up('.#{classname}').hide(); $(this).previous().value = '1'")
      out
    end
  end

  def add_item_link(name, form)
    link_to_function name do |page|
      item = render(:partial => 'item', :locals => { :df => form, :item => Item.new })
      page << %(
        if (window.item_id == null )
          item_id = 1;
        else
          item_id++; 
        $('donation_items').insert({ bottom: "#{ escape_javascript item }".replace(/_1_/g, "_" + item_id + "_").replace(/\\[1\\]/g, "[" + item_id + "]") });
      )
    end
  end

  def add_image_link(name, form)
    link_to_function name do |page|
      image = render(:partial => 'image', :locals => { :df => form, :image => DonationImage.new })
      page << %(
        if (window.image_id == null )
          image_id = 1;
        else
          image_id++; 
        $('donation_images').insert({ bottom: "#{ escape_javascript image}".replace(/_1_/g, "_" + image_id + "_").replace(/\\[1\\]/g, "[" + image_id + "]") });
      )
    end
  end
end
