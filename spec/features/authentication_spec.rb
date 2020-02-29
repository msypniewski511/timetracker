require 'rails_helper'

describe "user authentication" do
  it "allows signin with valid credentials" do
    sign_in_user(create(:user))

    expect(page).to have_content('Zalogowałeś się pomyślnie')
  end

  it "does not allows signin with invalid credentials" do
    sign_in_user(create(:user), password: "wrong password")
    expect(page).to have_content('Nieprawidłowy e-mail lub hasło')
  end

  it "allows user to sign out" do
    sign_in_user(create(:user))

    visit root_path
    click_link "Wyloguj się"
    expect(page).to have_content("Wylogowanie powiodło się") 
  end

  def sign_in_user(user, opts={})
    visit new_user_session_path
    fill_in "Email",	with: user.email
    fill_in "user_password",	with: (opts[:password] || user.password)
    click_button "Zaloguj się"
  end
  
end
