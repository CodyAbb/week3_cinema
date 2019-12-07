require_relative('../db/psql_runner')
require_relative('./film')

class Customer

  attr_reader :id
  attr_accessor :name, :funds, :ticket_count

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
    @ticket_count = options['ticket_count'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds, ticket_count) VALUES ($1, $2, $3) RETURNING id"
    values = [@name, @funds, @ticket_count]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
   sql = "UPDATE customers SET (name, funds) = ($1, $2, $3) WHERE id = $4"
   values = [@name, @funds, @ticket_count, @id]
   SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    return customer_data.map{|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films()
    sql = "
      SELECT films.* FROM films
      INNER JOIN tickets ON tickets.film_id = films.id
      WHERE tickets.customer_id = $1;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{ |hash| Film.new(hash) }
  end

  def ticket_purchase()
    films = self.films()
    price_array = films.map { |object| object.price.to_i }
    p price_array
    total_cost = price_array.reduce(0){|sum, n| sum + n}
    p total_cost
    @funds - total_cost
    @ticket_count + price_array.length
    return "Customer has #{@ticket_count} number of tickets and #{@funds} funds left"
  end

end
