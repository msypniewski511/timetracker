require 'rails_helper'

describe "user authentication" do
  let(:user) { build(:user) }
  let!(:account) { create(:account, owner: user) }

  it "allows signin with valid credentials" do
    sign_in_user(user, subdomain: account.subdomain)

    expect(page).to have_content('Zalogowałeś się pomyślnie')
  end

  it "does not allows signin with invalid credentials" do
    sign_in_user(create(user, subdomain: account.subdomain, password: "wrong password"))
    expect(page).to have_content('Nieprawidłowy e-mail lub hasło')
  end

  it "does not allow user to sign in unless on subdomain" do
    expect{ visit new_user_session_path }.to raise_error ActionController::RoutingError 
  end
  
  it "allows user to sign out" do
    sign_in_user(user, subdomain: account.subdomain) 

    click_link "Wyloguj się"
    expect(page).to have_content("Wylogowanie powiodło się") 
  end

  def sign_in_user(user, opts={})
    visit new_user_session_url(subdomain: opts[:subdomain])
    fill_in "Email",	with: user.email
    fill_in "user_password",	with: (opts[:password] || user.password)
    click_button "Zaloguj się"
  end
  
end
