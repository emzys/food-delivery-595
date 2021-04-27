require 'csv'
require_relative '../models/customer'
require_relative 'base_repository'

class CustomerRepository < BaseRepository

  private

  def build_element(row)
    row[:id] = row[:id].to_i # turn id into integer
    Customer.new(row)
  end
end
