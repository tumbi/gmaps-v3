class Character < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :fences, :gmaps, :latitude, :longitude, :name, :contractendon, :email, :contract_number, :mobile_number, :user_id
  validates :email, :presence => true
  validates :address, :presence => true
  validates :contractendon, :presence => true
  validates :mobile_number, :presence => true
  validates :contract_number, :presence => true, :uniqueness => true

  acts_as_gmappable

  searchable do
    text :address, :name, :email, :stored => true
    integer :fences, :stored => true
    integer :contract_number, :stored => true
    integer :mobile_number, :stored => true
    time    :contractendon, :stored => true
    integer :user_id, :stored => true
  end
  handle_asynchronously :solr_index
  handle_asynchronously :remove_from_index

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

  def self.send_reminder_email
    Character.first.update_attribute('name',"aaaa")
    @characters = Character.all
    @characters.each do |cont|
      @contractors.each do |cont|
        CharacterExpiry.contract_email(cont,cont.user).deliver
      end
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

  protected
  def resque_solr_update
    Resque.enqueue(SolrUpdate, self, id)
  end
  def resque_solr_remove
    Resque.enqueue(SolrRemove, self, id)
  end
end
