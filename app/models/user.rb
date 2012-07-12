class User < ActiveRecord::Base
  validates :name, :uid, :provider, :presence => true

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

  def represents? candidate
    Ownership.where(:candidate_id => candidate.id, :user_id => self.id).exists?
  end
end
