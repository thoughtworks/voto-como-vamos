class User < ActiveRecord::Base
  validates :name, :uid, :provider, :presence => true

  has_many :ownerships

  attr_accessible # none

  def self.create_with_auth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end


  def self.send_pesquisa_to_users
    uniq.pluck(:email).each { |email| UserMailer.pesquisa(email).deliver }
  end
end
