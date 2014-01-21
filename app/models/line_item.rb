class LineItem < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # security ..................................................................
  # relationships .............................................................
  belongs_to :order, inverse_of: :line_items
  belongs_to :variant

  has_one :product, through: :variant
  # validations ...............................................................
  before_validation :copy_price

  validates :variant, presence: true
  validates :quantity, numericality: {
    only_integer: true,
    greater_than: -1
    # message: Spree.t('validation.must_be_int')
  }
  validates :price, numericality: true
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  delegate :name, :description, to: :variant
  # class methods .............................................................
  # public instance methods ...................................................
  def copy_price
    # self.price = variant.price if variant && price.nil?
  end

  def amount
    price * quantity
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
