# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'json'
require 'open-uri'

Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
user_serialized = open(url).read
user = JSON.parse(user_serialized)
ingredients = []
portion = ["tiny bit of", "a lot of", "whole bottle of"]

user['drinks'].each do |ingredient|
  ingredient = Ingredient.create(name:ingredient["strIngredient1"])
  ingredients << ingredient
end

10.times do
  name = Faker::JapaneseMedia::DragonBall.character

  cocktail = Cocktail.new(name: name)
  cocktail.save

  rand(2..8).times do
    dose = Dose.new
    dose.cocktail = cocktail
    dose.ingredient = ingredients.sample
    dose.description = portion.sample
    dose.save
  end
end
