require 'rails_helper'

describe "subdomians" do
  let(:account) { create(:acount_with_schema) }

  it "allows valid accounts" do
    visit root_url(subdomain: account.subdomain)
    expect(page.current_url).to include(account.subdomain)
  end
  
  it "forces users to login before accessing subdomain content" do
    visit root_url(subdomain: account.subdomain)
    expect(page).to have_content 'Zaloguj się lub Zarejestruj przed kontynuowaniem.' 
  end
  
  it "redirects invalid account" do
    visit root_url(subdomain: 'random-subdomain')
    expect(page).to have_content('Strona, której szukasz, nie istnieje.')
  end
end
