require 'rails_helper'

describe "user authentication" do
  let(:user) { build(:user) }
  let(:account) { create(:acount_with_schema, owner: user) }

  it "allows signin with valid credentials" do
    sign_in_user(user, subdomain: account.subdomain)

    expect(page).to have_content('Zalogowałeś się pomyślnie')
  end

  it "does not allows signin with invalid credentials" do
    sign_in_user(user, subdomain: account.subdomain, password: "wrong password")
    expect(page).to have_content('Nieprawidłowy e-mail lub hasło')
  end

  it "does not allow user to sign in unless on subdomain" do
    expect{ visit new_user_session_path }.to raise_error ActionController::RoutingError 
  end
  
  it "does not allow user from domain to sign in on another subdomain" do
    user2 = build(:user)
    account2 = create(:acount_with_schema, owner: user2)

    sign_in_user(user2, subdomain: account2.subdomain)
    expect(page).to have_content('Zalogowałeś się pomyślnie')

    sign_in_user(user2, subdomain: account.subdomain)
    expect(page).to have_content('Nieprawidłowy e-mail lub hasło')
  end
  

  it "allows user to sign out" do
    sign_in_user(user, subdomain: account.subdomain) 

    click_link "Wyloguj się"
    expect(page).to have_content("Wylogowanie powiodło się") 
  end
  
end
