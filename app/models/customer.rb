class Customer < ApplicationRecord
  belongs_to :user

  # instance methods
  def full_name
    "#{self.first_name} #{self.last_name}"
  end


  # class methods
  def self.all_customers(id)
    Customer.find_by_sql(
      "
      SELECT * 
      FROM customers AS c
      WHERE c.user_id = #{id}
      "
    )
  end

  def self.single_customer(user_id, customer_id)
    # ["query", arg1, arg2]
    Customer.find_by_sql([
      "
      SELECT *
      FROM customers AS c
      WHERE c.id = ?
      ",
      customer_id])
  end

  def self.create_customer(p, id)
    

  end
end
