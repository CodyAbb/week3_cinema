require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

film1 = Film.new({
  'title' => "Die Hard",
  'price' => 5
  })

film1.save()

film2 = Film.new({
  'title' => "White Christmas",
  'price' => 10
  })

film2.save()


customer1 = Customer.new({
  'name' => "Joe",
  'funds' => "50"
  })
customer1.save()

customer2 = Customer.new({
  'name' => "Rebecca",
  'funds' => "20"
  })
customer2.save()

customer3 = Customer.new({
  'name' => "Victoria",
  'funds' => "80"
  })
customer3.save()


ticket1 = Ticket.new({
  'film_id' => film1.id,
  'customer_id' => customer1.id
  })
ticket1.save()

ticket2 = Ticket.new({
  'film_id' => film1.id,
  'customer_id' => customer2.id
  })
ticket2.save()

ticket3 = Ticket.new({
  'film_id' => film2.id,
  'customer_id' => customer3.id
  })
ticket3.save()

ticket4 = Ticket.new({
  'film_id' => film2.id,
  'customer_id' => customer2.id
  })
ticket4.save()

binding.pry
nil
