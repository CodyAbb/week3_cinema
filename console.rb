require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

# Ticket.delete_all()
Film.delete_all()
# Customer.delete_all()

film1 = Film.new({
  'name' => "Die Hard",
  'price' => 5
  })

film1.save()

binding.pry
nil
