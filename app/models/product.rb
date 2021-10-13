require 'csv' 
class Product < ApplicationRecord
  before_validation :downcase_brand_and_code
 
  validates :brand, :code, :cost, presence: true
  validates :stock, presence: true, length: { minimum: 0 }

  def self.import(file)
  	CSV.foreach(file.pathmap, headers: true) do |row|
      to_hash = row.to_hash 
      product = Product.create!(brand: to_hash['Производитель'], 
        			            code: to_hash['Артикул'], 
        		                stock: to_hash['Количество'],
        		                cost: to_hash['Цена'],
        		                name: to_hash['Наименование']
                               )
    end
  end

  def downcase_brand_and_code
  	self.brand.downcase!
  	self.code.downcase!
  end
end
