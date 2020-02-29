require 'spec_helper'

describe 'account creation' do
  it 'allows user to ceate account' do
    visit root_path
    click_link 'Utwórz konto'

    # fill_in "Imie",	with: "sometext" 
    # fill_in "Nazwisko",	with: "Sypniewski"
    # fill_in "Email",	with: "test@test.pl"
    # fill_in "Hasło",	with: "password"
    # fill_in "Potwierdzenie hasła",	with: "password"
    fill_in "Subdomena",	with: "kasia"
    click_button "Utwórz konto"


    expect(page).to have_content('Rejestracja została zakończona pomyślnie') 
  end
end