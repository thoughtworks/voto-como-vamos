class User
  include Mongoid::Document
 
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  
  validates :name, :uid, :provider, :email, :presence => true

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
end
