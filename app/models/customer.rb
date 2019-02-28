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
      WHERE c.id = ? AND c.user_id = ?
      ",
      customer_id, user_id]).first
  end

  def self.create_customer(p, id)
    Customer.find_by_sql(["
      INSERT INTO customers (first_name, last_name, email, phone, user_id, created_at, updated_at)
      VALUES (:first, :last, :email, :phone, :user_id, :created_at, :updated_at);
      ", 
      {
        first: p[:first_name],
        last: p[:last_name],
        email: p[:email],
        phone: p[:phone],
        user_id: id,
        created_at: DateTime.now,
        updated_at: DateTime.now
      }
    ])

  end

  def self.update_customer(p, id)
    Customer.find_by_sql(["
      UPDATE customers AS c
      SET first_name = ?, last_name = ?, email = ?, phone = ?, updated_at = ?
      WHERE c.id = ?
      ",
      p[:first_name], p[:last_name], p[:email], p[:phone], DateTime.now, id
      ])
  end

  def self.delete_customer(customer_id)
    Customer.find_by_sql(["
      DELETE FROM customers AS c
      WHERE c.id = ?",
      customer_id])
  end
end
