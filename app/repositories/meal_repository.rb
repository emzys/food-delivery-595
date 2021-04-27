require 'csv'
require_relative '../models/meal'
require_relative 'base_repository'

class MealRepository < BaseRepository

  def build_element(row)
    row[:id] = row[:id].to_i # turn id into integer
    row[:price] = row[:price].to_i # turn price into integer
    return Meal.new(row)
  end
end
