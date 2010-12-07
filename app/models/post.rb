require 'paperclip'
require 'will_paginate'

class Post < ActiveRecord::Base
	validates :name,  :presence => true
	validates :title, :presence => true, :length => { :minimum => 5 }
	
	has_many :comments, :dependent => :destroy
	has_many :tags
 
	accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

    #has_attached_file :file, :path => ":attachment/:id/:style.:extension"
    #has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
    #has_attached_file :file, :url => ":attachment/:id/:style.:extension"

	# has_attached_file :file, :storage => :s3
	# has_attached_file :file, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
	
	
	has_attached_file :file, 
                                        :styles => { :medium => "300x300>", :thumb => "100x100>" },
#                                        :url => ":s3_alias_url",                  
                                        :storage => :s3,
                                        :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                        :path => "posts/:attachment/:id/:style.:extension",
                                        :bucket => 'actwell'
	
	cattr_reader :per_page
	@@per_page = 6
	
end
