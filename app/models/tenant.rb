class Tenant < ApplicationRecord
    validates_presence_of :name
    before_create :_before_create

    def _before_create
        self.set_default_slug
    end

    protected

    def set_default_slug
        unless self.slug.present?
            self.slug = self.name[0,3]
        end
    end

end
