class Phone < ActiveRecord::Base
  include StringNormalizer

  belongs_to :customer
  belongs_to :address

  before_validation do
    self.number = normalize_as_phone_number(number)
    self.number_for_index = number.gsub(/\D/, '') if number
  end

  before_create do
    self.customer = address.customer if address
<<<<<<< HEAD
=======
    self.last_four_digits = self.number_for_index[-4, 4]
>>>>>>> 8ed8f0e05febec6ed431b754499b168183b68177
  end

  validates :number, presence: true,
    format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true }
end
