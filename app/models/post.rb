require 'paperclip'
require 'will_paginate'

class Post < ActiveRecord::Base
	validates :name,  :presence => true
	validates :title, :presence => true, :length => { :minimum => 5 }
	
	has_many :comments, :dependent => :destroy
	has_many :tags
 
	accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
	
    has_attached_file :file, :path => "/:class/:attachment/:style_:basename.:extension"
    has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
    has_attached_file :file, :url => "/:class/:attachment/:style_:basename.:extension"

	
	cattr_reader :per_page
	@@per_page = 6
	
end
