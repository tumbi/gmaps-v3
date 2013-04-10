class Marker < ActiveRecord::Base
  attr_accessible :photo, :duration, :character_id

  belongs_to :character

  has_attached_file :photo,
  :storage => :filesystem, :path => ":rails_root/public/:class/:attachment/:id/:basename.:extension",
#  :storage => 's3',
#    :s3_credentials => {:access_key_id => "AKIAJYUYZM5LGPF5NAVA" ,:secret_access_key => "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",:s3_endpoint => 'popupstorz.s3-website-eu-west-1.amazonaws.com'},
#    :bucket => "popupstorz",
#    :path => "/system/ugc/:class/:id/:style/:basename.:extension",
    :default_style => :original

end
