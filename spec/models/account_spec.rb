require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { should validate_presence_of :owner }
    it { should validate_presence_of :subdomain }
    # it do
    #   should validate_uniqueness_of(:subdomain).
    #     case_insensitive
    # end
    it { should validate_uniqueness_of(:subdomain).case_insensitive }

    it { should allow_value('bolrand').for(:subdomain) }
    it { should allow_value('test').for(:subdomain) }

    it { should_not allow_value("www").for(:subdomain) }
    it { should_not allow_value("WWW").for(:subdomain) }
    it { should_not allow_value(".test").for(:subdomain) }
    it { should_not allow_value("test/").for(:subdomain) }

    it "should validate case insensitive uniqueness" do
      create(:account, subdomain: 'Test')
      expect(build(:account, subdomain: 'test')).to_not be_valid  
    end
    
  end

  describe "associations" do
    it { should belong_to :owner }
  end
  
end
