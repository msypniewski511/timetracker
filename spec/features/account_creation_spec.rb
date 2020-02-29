require 'spec_helper'

describe 'account creation' do
  it 'allows user to ceate account' do
    visit root_path
    click_link 'Utwórz konto'

    
    # binding.pry
    fill_in "account_owner_attributes_first_name",	with: "sometext" 
    fill_in "account_owner_attributes_last_name",	with: "Sypniewski"
    fill_in "account_owner_attributes_email",	with: "test@test.pl"
    fill_in "account_owner_attributes_password",	with: "password"
    fill_in "account_owner_attributes_password_confirmation",	with: "password"
    fill_in "account_subdomain",	with: "kasia"
    click_button "Utwórz konto"


    expect(page).to have_content('Rejestracja została zakończona pomyślnie') 
  end
end