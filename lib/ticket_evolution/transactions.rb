module TicketEvolution
  class Transactions < Endpoint
    include TicketEvolution::Modules::List
    include TicketEvolution::Modules::Show
  end
end
