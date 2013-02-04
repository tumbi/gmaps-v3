class Character < ActiveRecord::Base
  attr_accessible :address, :fences, :gmaps, :latitude, :longitude, :name
  acts_as_gmappable

  def gmaps4rails_address
 address 
  end
  def gmaps4rails_infowindow
  "<b>#{name}</b>
  <p>
  <b><i> Number of Fences: #{fences}</b></i> </p>"
  end
  def gmaps4rails_marker_picture
   {
      "picture" => "/images/fencered.png",
      "width" => "25",
      "height" => "39"
    }
  end
end
