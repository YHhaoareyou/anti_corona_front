class Post < ApplicationRecord
  has_one :demand
  has_one :supply
end
