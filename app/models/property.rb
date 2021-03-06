class Property < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # security ..................................................................
  # relationships .............................................................
  has_and_belongs_to_many :prototypes
  has_many :product_properties, dependent: :delete_all, inverse_of: :property
  has_many :products, through: :product_properties
  # validations ...............................................................
  validates :name, :presentation, presence: true
  # callbacks .................................................................
  after_touch :touch_all_products
  # scopes ....................................................................
  scope :sorted, -> { order(:name) }
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
  private
    def touch_all_products
      products.each(&:touch)
    end
end
