class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present? && Account.where(subdomain: request.subdomain).first
  end
end

class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
  constraints(SubdomainPresent) do
    root 'lessons#index', as: :subdomain_root
    devise_for :users
  end

  constraints(SubdomainBlank) do
    root 'welcome#index'
    resources :accounts, only: [:new, :create]
  end
  root 'welcome#index', as: :welcome_root
end
