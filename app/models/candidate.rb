require 'valid_email'
class Candidate < ActiveRecord::Base
  has_many :proposals
  has_many :ownerships

  before_create :generate_obfuscated_slug

  validates :name, presence: true
  validates :about, :length => { :maximum => 500 }, :allow_nil => true
  validates :phone, :length => { :in => 8..14 }, :allow_nil => true, :allow_blank => true
  validates_format_of :phone, :with => /[(]?\d+[)]?[-]?/, :allow_nil =>true, :allow_blank => true
  validates :email, :presence => true, :email => true
  validates :site, :blog, :facebook, :twitter, :url => true, :allow_nil => true

  attr_accessible :about, :phone, :email, :site, :blog, :facebook, :twitter, :press_agent, :elected

  def self.text_search(query_string, page = 1)
    name = "%" << query_string << "%" unless query_string.nil?
    where("name like ?", (name || "")).paginate(:page => page)
  end

  def generate_obfuscated_slug
    self.obfuscated_slug = Digest::SHA1.hexdigest name
  end

  def represented_by? user
    Ownership.where(:candidate_id => self.id, :user_id => user.id).exists? if user
  end
end
