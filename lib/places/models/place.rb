class Place
  include Mongoid::Document
  
  field :name, :type => String
  field :slug, :type => String
  field :description, :type => String  
  field :website, :type => String
  field :phone, :type => String  
  field :hours, :type => String 
  
  field :address, :type => String
  field :city, :type => String
  field :state, :type => String
  field :postal_code, :type => String
  field :country, :type => String
  
  field :lat, :type => Float
  field :lng, :type => Float
  
  before_create :set_slug

  validates_presence_of :name
  validates_uniqueness_of :name
  
  class << self
    def find_by_city(name)
      where :city => /#{name}/i
    end
  
    def self.search(country, alpha)
      country ||= I18n.default_locale
      q = Place.where(:country => country.upcase)
    
      unless alpha.blank?
        range_parts = alpha.split('-')
      
        if range_parts.length == 1
          q = q.where(:city => /^#{alpha}/i)
        elsif range_parts.length == 2
          q = q.where(:city => /^[#{alpha}]/i)
        end
      end
      q.all
    end
  end  
  
  def full_address
    [address, city, state, postal_code].reject { |a| a.blank? }.join(', ')
  end
  
  def lat_lng
    lat && lng ? "#{lat},#{lng}" : nil
  end

  def save_unless_exists
    save if new_record? && Place.where(:name => /#{name}/i).count == 0
  end  
  
  private
  
  def set_slug
    self.slug = name.gsub(/[^A-Z0-9]/i, '_').downcase
    count = Place.where(:slug => slug).count
    self.slug = "#{self.slug}_#{count}" if count > 0
  end  
end