class PaymentMethod < ActiveRecord::Base
  # extends ...................................................................
  acts_as_paranoid
  # includes ..................................................................
  include PaymentProcessing
  # security ..................................................................
  # relationships .............................................................
  has_many :payments
  # validations ...............................................................
  validates :name, presence: true
  # callbacks .................................................................
  # scopes ....................................................................
  scope :production, -> { where(environment: 'production') }
  # additional config .........................................................
  DISPLAY = [:both, :front_end, :back_end]
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
