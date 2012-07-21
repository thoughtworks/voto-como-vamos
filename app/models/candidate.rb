require 'valid_email'
class Candidate < ActiveRecord::Base
  has_many :proposals

  before_create :generate_obfuscated_slug

  validates :name, presence: true
  validates :about, :length => { :maximum => 500 }, :allow_nil => true
  validates :phone, :length => { :in => 8..14 }, :allow_nil => true, :allow_blank => true
  validates_format_of :phone, :with => /[(]?\d+[)]?[-]?/, :allow_nil =>true, :allow_blank => true
  validates :email, :presence => true, :email => true
  validates :site, :blog, :facebook, :twitter, :url => true, :allow_nil => true

  searchable do
    text :name
    text :short_name
    string :short_name
  end

  def self.text_search(query_string, page = 1)
    search do
      fulltext query_string, :highlight => true
      paginate :page => page
      order_by(:short_name)
    end
  end

  def generate_obfuscated_slug
    self.obfuscated_slug = Digest::SHA1.hexdigest name
  end
end
