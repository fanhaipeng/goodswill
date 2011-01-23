module DeliveriesHelper
  def get_admin_step status
    step = :pack 
    case status
    when Delivery::OPEN then step = :pack
    when Delivery::PACKED then step = :ship
    when Delivery::SHIPPED then step = :confirm
    when Delivery::CONFIRMED then step = :done
    else
      step = :pack
    end
    step
  end

  def get_admin_title status
    title = "Stuff to pack" 
    case status
    when Delivery::OPEN then title = "Stuff to pack" 
    when Delivery::PACKED then title = "Stuff to ship" 
    when Delivery::SHIPPED then title = "Deliveries to confirm"
    when Delivery::CONFIRMED then title = "Closed deliveries" 
    else
      title = "Stuff to pack" 
    end
    title
  end
end
