require "dogapi"

module Fluent
  class OutDatadogEvent < Fluent::Output
    Fluent::Plugin.register_output('datadog_event', self)

    config_param :api_key, :string
    config_param :app_key, :string, :default => nil
    config_param :date_happend, :string, :default => nil
    config_param :priority, :string, :default => nil
    config_param :host, :string, :default => nil
    config_param :tags, :string, :default => nil
    config_param :alert_type, :string, :default => nil
    config_param :aggregation_key, :string, :default => nil
    config_param :source_type_name, :string, :default => nil

    def configure(conf)
      super
      #
    end

    def start
      super
      # ...
    end

    def shutdown
      super
      # ...
    end

    def configure(conf)
      super

    end

    def emit(tag, es, chain)
      chain.next
      es.each do |time,record|
        record.select do |k,v|
          event = record[k]
          post_event(k, event)
        end
      end
    end

    def post_event(event_key, event)
      dog = Dogapi::Client.new(@api_key)
      dog.emit_event(Dogapi::Event.new("#{event}", :msg_title => "#{event_key}"))
      # for debug
      # puts "debug_out: #{@api_key} - #{event_key} - #{event}\n"
    end

  end
end
