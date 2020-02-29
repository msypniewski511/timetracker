class Account < ApplicationRecord
  RESTRICTED_SUBDOMAIN = %w[www]

  validates :subdomain, presence: true,
                        uniqueness: { case_sensitive: false },
                        format: { with: /\A[\w\-]+\Z/i, message: 'Zawiera nieprawidłowe znaki' },
                        exclusion: { in: RESTRICTED_SUBDOMAIN, message: 'Zabroniony' }
  before_validation :downcase_subdomain

  private
  def downcase_subdomain
    self.subdomain = subdomain.try(:downcase)
  end
end
