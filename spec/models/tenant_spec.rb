require 'rails_helper'

RSpec.describe Tenant, type: :model do
   
  subject(:tenant) {create(:tenant)}
 
  describe'set_default_slug for tenant' do
    it 'with slug is present' do
      slug = subject.slug
      subject.send(:set_default_slug)
      expect(subject.slug).to eq(slug)
    end
    it 'slug is not present' do
      subject.slug = nil
      expect(subject.slug).to eq(nil)
      subject.send(:set_default_slug)
      expect(subject.slug).not_to eq(nil)
      expect(subject.slug).to eq(subject.name[0,3])
    end
  end
end
