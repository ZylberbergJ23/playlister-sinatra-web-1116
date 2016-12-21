module Slugifiable
  module InstanceMethods
    def slug
      name.downcase.strip.gsub(' ', '-')
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      anti_slug = slug.gsub('-', ' ')
      self.where("name LIKE ?", anti_slug).first
    end
  end
end
