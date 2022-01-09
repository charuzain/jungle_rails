class Category < ActiveRecord::Base

   has_many :products  
#  a category has many products 
end
