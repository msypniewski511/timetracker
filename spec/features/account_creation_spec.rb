require 'spec_helper'

describe 'account creation' do
  let(:subdomain) { FactoryBot.generate(:subdomain) }
  before(:each) { sign_up(subdomain) }

  it 'allows user to ceate account' do
    # expect(page).to have_content('Rejestracja została zakończona pomyślnie') 
    expect(page.current_url).to include(subdomain)
    expect(Account.all.count).to eq(1) 
  end

  it 'allows access to subdomain' do
    visit root_url(subdomain: subdomain)
    expect(page.current_url).to include(subdomain)
  end

  it "does not allow account creation on subdomain" do
    subdomain = FactoryBot.generate(:subdomain)
    sign_up(subdomain)
    user = User.first
    sign_in_user(user, subdomain: subdomain)
    expect { visit new_account_url(subdomain: subdomain) }.to raise_error ActionController::RoutingError
  end

  it 'allows account folloup creation' do
    Apartment::Tenant.reset
    DatabaseCleaner.clean
    subdomain5 = "#{subdomain}5"
    sign_up(subdomain5)
    expect(page.current_url).to include(subdomain5)
    expect(Account.all.count).to eq(2) 
  end

end