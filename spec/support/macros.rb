def drop_schemas
  # connection = ActiveRecord::Base.connection.raw_connection
  # schemas = connection.query(%Q{
  #   SELECT 'drop schema ' || nspname || ' cascade;'
  #   from pg_namespace
  #   WHERE nspname != 'public'
  #   AND nspname NOT LIKE 'pg_%'
  #   AND nspname != 'information_schema';
  # })
  # schemas.each do |qu|
  #   connection.query(qu.values.first)
  # end
  Account.all.each do |a|
    Apartment::Tenant.drop(a.subdomain)
    a.delete
  end
end

def sign_up(subdomain)
  visit root_url(subdomain: false)
  click_link 'Utwórz konto'

  fill_in "account_owner_attributes_first_name",	with: "sometext" 
  fill_in "account_owner_attributes_last_name",	with: "Sypniewski"
  fill_in "account_owner_attributes_email",	with: "test@test.pl"
  fill_in "account_owner_attributes_password",	with: "password"
  fill_in "account_owner_attributes_password_confirmation",	with: "password"
  fill_in "account_subdomain",	with: subdomain
  click_button "Utwórz konto"
end

def sign_in_user(user, opts={})
  visit new_user_session_url(subdomain: opts[:subdomain])
  fill_in "Email",	with: user.email
  fill_in "user_password",	with: (opts[:password] || user.password)
  click_button "Zaloguj się"
end