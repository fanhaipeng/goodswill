module DeliveriesHelper
  def get_index_page_title status
    title = ""
    case status
    when Delivery::PACKED then title = "Index of deliveries for shipping"
    when Delivery::SHIPPED then title = "Index of deliveries for confirmation"
    when Delivery::CONFIRMED then title = "Index of closed deliveries"
    else
      title = "Index of deliveries for packing"
    end
    title
  end
end
