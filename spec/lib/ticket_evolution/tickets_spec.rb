require 'spec_helper'

describe TicketEvolution::Tickets do
  let(:klass) { TicketEvolution::Tickets }
  let(:single_klass) { TicketEvolution::Ticket }
  let(:update_base) { {'url' => '/tickets/1'} }

  it_behaves_like 'a ticket_evolution endpoint class'
  it_behaves_like 'a list endpoint'
  it_behaves_like 'a show endpoint'
  it_behaves_like 'an update endpoint'

  it "should have a base path of /ticket_groups" do
    klass.new({:parent => Fake.connection}).base_path.should == '/tickets'
  end

end
