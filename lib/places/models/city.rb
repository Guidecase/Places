class City
  include Mongoid::Document

  field :name, :type => String
  field :country, :type => String
  field :places_count, :type => Integer
  
  class << self
    def from_places(places)
      places ? places.map(&:city).uniq.sort : nil
    end
  
    def find_by_name(name)
      where({:name => /#{name}/i}).first
    end  
  end
end