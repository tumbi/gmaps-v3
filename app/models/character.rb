#require 'geocoder/models/active_record'
class Character < ActiveRecord::Base

  extend ::Geocoder::Model::ActiveRecord

  geocoded_by :address_for_geocode
  reverse_geocoded_by :latitude, :longitude

  belongs_to :user
  attr_accessible :address, :fences, :gmaps, :latitude, :longitude, :name, :contractendon, :email, :contract_number, :mobile_number, :user_id
  validates :email, :presence => true
  validates :address, :presence => true
  validates :contractendon, :presence => true
  validates :mobile_number, :presence => true
  validates :contract_number, :presence => true, :uniqueness => true

  acts_as_gmappable
  
  has_many :markers
  accepts_nested_attributes_for :markers, :allow_destroy => true
  #  searchable do
  #    text :address, :name, :email, :stored => true
  #    integer :fences, :stored => true
  #    integer :contract_number, :stored => true
  #    integer :mobile_number, :stored => true
  #    time    :contractendon, :stored => true
  #    integer :user_id, :stored => true
  #  end
  def lessthan?
    if self.contractendon < 14.day.since.to_date && self.contractendon > Time.now.to_date
      return true
    end
  end

  def two_week_reminder?
    if self.contractendon < 14.day.since.to_date && self.contractendon > Time.now.to_date
      return true
    end
  end

  def weekly_reminder?
    if self.contractendon < 7.day.since.to_date && self.contractendon > Time.now.to_date
      return true
    end
  end

  def monthly_reminder?
    if self.contractendon < 30.day.since.to_date && self.contractendon > Time.now.to_date
      return true
    end
  end

  def expiretoday?
    if self.contractendon <= Time.now.to_date
      return true
    end
  end

  def self.send_reminder_email
    Character.all.each do |cont|
      setting = cont.user.notification_setting
      unless setting.blank?
        if setting.oneday_reminder
          if cont.expiretoday?
            
            CharacterExpiry.contract_email(cont,cont.user,cont.user.company.message_templates.last).deliver
          end
        end
        if setting.weekly_reminder
          if cont.weekly_reminder?
            
            CharacterExpiry.contract_email(cont,cont.user,cont.user.company.message_templates.last).deliver
          end
        end
        if setting.monthly_reminder
          if cont.monthly_reminder?
            
            CharacterExpiry.contract_email(cont,cont.user,cont.user.company.message_templates.last).deliver
          end
        end
        if setting.bimonthly_reminder
          if cont.two_week_reminder?
            
            CharacterExpiry.contract_email(cont,cont.user,cont.user.company.message_templates.last).deliver
          end
        end
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
    unless self.markers.blank?
      marker = ""
      if monthly_reminder?
        marker = self.markers.where("duration = 30")
        set_marker(marker)
      elsif two_week_reminder?
        marker = self.markers.where("duration = 15")
        set_marker(marker)
      elsif weekly_reminder?
        marker = self.markers.where("duration = 7")
        set_marker(marker)
      elsif expiretoday?
        marker = self.markers.where("duration = 0")
        set_marker(marker)
      else
        set_marker(marker)
      end

    else
      set_marker(marker)
    end

    #    if self.lessthan?
    #      {
    #        "picture" => "/images/FenceIcon.png",
    #        "width" => "25",
    #        "height" => "39"
    #      }
    #    else
    #      {
    #        "picture" => "/images/fencered.png",
    #        "width" => "25",
    #        "height" => "39"
    #      }
    #    end
  end

  def set_marker(marker)    
    if marker.blank?
      {
        "picture" => "/images/fencered.png",
        "width" => "25",
        "height" => "39"
      }
    else
      marker = marker.first
      {
        "picture" => "#{marker.photo.url(:original)}",
        "width" => "25",
        "height" => "39"
      }
    end
    
  end
  
end
