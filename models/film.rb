require_relative('../db/psql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
   sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
   values = [@title, @price, @id]
   SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    film_data = SqlRunner.run(sql)
    return film_data.map{|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "
      SELECT customers.* FROM customers
      INNER JOIN tickets ON tickets.customer_id = customers.id
      WHERE tickets.film_id = $1;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{ |hash| Customer.new(hash) }
  end

  def customer_check
    customers = self.customers()
    customer_array = customers.map { |object| object }
    return "Number of customers for this film is #{customer_array.length}"
  end

end
