class OptionType < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # security ..................................................................
  # relationships .............................................................
  has_many :option_values, -> { order(:position) }, dependent: :destroy, inverse_of: :option_type
  has_many :product_option_types, dependent: :destroy, inverse_of: :option_type
  has_many :products, through: :product_option_types
  has_and_belongs_to_many :prototypes
  # validations ...............................................................
  validates :name, :presentation, presence: true
  # callbacks .................................................................
  # after_touch :touch_all_products
  # scopes ....................................................................
  default_scope -> { order(:position) }
  # additional config .........................................................
  accepts_nested_attributes_for :option_values, allow_destroy: true
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
  private
    def touch_all_products
      products.find_each(&:touch)
    end
end
