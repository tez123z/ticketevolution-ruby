require 'spec_helper'

describe TicketEvolution::Ticket do
  subject { TicketEvolution::Ticket }
  let(:klass) { TicketEvolution::Ticket }
  let(:connection) { Fake.connection }
  let(:instance) { klass.new({:connection => connection, 'id' => 1}) }
  let(:params) { {:test => "1... 2... 3..."} }
  let(:plural_klass) { TicketEvolution::Tickets }
  let!(:plural_klass_instance) { plural_klass.new(:parent => connection) }

  it_behaves_like "a ticket_evolution model"

end