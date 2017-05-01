module TicketEvolution
  class Tickets < Endpoint
    include TicketEvolution::Modules::List
    include TicketEvolution::Modules::Show
  end
end