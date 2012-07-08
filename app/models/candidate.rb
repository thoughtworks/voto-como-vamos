require 'valid_email'
class Candidate < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :proposals

  before_create :generate_obfuscated_slug

  validates :name, presence: true
  validates :about, :length => { :maximum => 500 }, :allow_nil => true
  validates :phone, :length => { :is => 13 }, :allow_nil => true
  validates :email, :presence => true, :email => true
  validates :site, :blog, :facebook, :twitter, :url => true, :allow_nil => true

  def generate_obfuscated_slug
    self.obfuscated_slug = Digest::SHA1.hexdigest name
  end
end
