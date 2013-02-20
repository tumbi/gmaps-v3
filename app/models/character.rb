class Character < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :fences, :gmaps, :latitude, :longitude, :name, :contractendon, :email
  acts_as_gmappable

def lessthan?
  if self.contractendon < 14.day.since.to_date && self.contractendon > Time.now.to_date
    return true
  end
end

def expiretoday?
  if self.contractendon <= Time.now.to_date
    return true
  end
end



  def gmaps4rails_address
 address 
  end
  def gmaps4rails_infowindow
  "<b>#{name}</b>
  <p>
  <b><i> Number of Fences: #{fences}</b></i> </p>"
  end
  def gmaps4rails_marker_picture
    if self.lessthan?
   {
     "picture" => "/images/FenceIcon.png",
      "width" => "25",
      "height" => "39"
    }
  else
    {
     "picture" => "/images/fencered.png",
      "width" => "25",
      "height" => "39"
    }
  end
  end
end
