class Account < ApplicationRecord
  RESTRICTED_SUBDOMAIN = %w[www]

  belongs_to :owner, class_name: 'User'

  validates :owner, presence: true
  validates :subdomain, presence: true,
                        uniqueness: { case_sensitive: false },
                        format: { with: /\A[\w\-]+\Z/i, message: 'Zawiera nieprawidłowe znaki' },
                        exclusion: { in: RESTRICTED_SUBDOMAIN, message: 'Zabroniony' }
  before_validation :downcase_subdomain

  accepts_nested_attributes_for :owner
  private
  def downcase_subdomain
    self.subdomain = subdomain.try(:downcase)
  end
end
