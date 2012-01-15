module TicketEvolution
  class Event < TicketEvolution::Base
    attr_accessor :category ,:configuration ,:id ,:name ,:occurs_at ,:performances ,:products_count ,:state ,:updated_at ,:url ,:venue

    def initialize(response)
      super(response)

      self.id             = @attrs_for_object["id"]
      self.url            = @attrs_for_object["url"]
      self.name           = @attrs_for_object["name"]
      self.category       = @attrs_for_object["category"]
      self.updated_at     = @attrs_for_object["updated_at"]
      self.occurs_at      = @attrs_for_object["occurs_at"]
      self.performances   = @attrs_for_object["performances"]
      self.venue          = @attrs_for_object["venue"]
      self.configuration  = @attrs_for_object["configuration"]
      self.state          = @attrs_for_object["state"]
      self.products_count = @attrs_for_object["products_count"]
    end

    class << self

      def list(params)
        query              = build_params_for_get(params).encoded
        path               = "#{api_base}/events?#{query}"
        response           = TicketEvolution::Base.get(path)
        response           = process_response(TicketEvolution::Event,response)
      end

      def show(id)
        path               = "#{api_base}/events/#{id}?"
        response           = TicketEvolution::Base.get(path)
        Event.new(response)
      end

      # Association Proxy Dynamic Methods
      %w(performer venue configuration category occurs_at name).each do |facet|
        parameter_name = if facet == "name" || facet == "occurs_at"
                           facet
                         elsif facet == "performer"
                           "performances[performer_id]"
                         else
                           "#{facet}_id"
                         end

        define_method("find_by_#{facet}") do |parameter|
          value = parameter.encoded
          self.list({parameter_name.intern => parameter})
        end
      end


      # Builders For Array Responses , Template for Object
      def raw_from_json(event)
        ActiveSupport::HashWithIndifferentAccess.new({
          :name           => event['name'],
          :category       => event["category"],
          :url            => event["url"],
          :id             => event["id"].to_i,
          :updated_at     => event["updated_at"],
          :venue          => event['venue'],
          :state          => event['state'],
          :configuration  => event['configuration'],
          :occurs_at      => event['occurs_at'],
          :performances   => event['performances'],
          :products_count => event['products_count']
        })
      end

      def build_for_event(response)
        events = response[:body].inject([]) do |events,event|
          response_for_object = {}
          response_for_object[:body]           = event
          response_for_object[:response_code]  = response[:response_code]
          response_for_object[:errors]         = response[:errors]
          response_for_object[:server_message] = response[:server_message]

          events.push(Event.new(response_for_object))
        end
        TicketEvolution::Event.collection = events
        return events
      end

      # Acutal api endpoints are matched 1-to-1 but for AR style convience AR type method naming is aliased into existance
      alias :find :show
    end
  end
end
