require "dogapi"

module Fluent
  class OutDatadogEvent < Fluent::Output
    Fluent::Plugin.register_output('out_datadog_event', self)

    config_param :api_key, :string
    config_param :app_key, :string, :default => nil
    config_param :date_happend, :string, :default => nil
    config_param :priority, :string, :default => nil
    # config_param :host, :string, :default => nil
    config_param :tags, :string, :default => nil
    config_param :alert_type, :string, :default => nil
    config_param :aggregation_key, :string, :default => nil
    config_param :source_type_name, :string, :default => 'fluentd'

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

    def emit(tag, es, chain)
      chain.next
      es.each do |time,record|
        record.select do |k,v|
          event_msg = record[k]
          post_event(k, event_msg)
        end
      end
    end

    def post_event(event_key, event_msg)

      dog = Dogapi::Client.new(@api_key)
      res = dog.emit_event(Dogapi::Event.new(
        "#{event_msg}", 
        :msg_title => "#{event_key}", 
        :date_happend => @date_happend,
        :priority => @priority,
        # :host => @host,
        :tags => @tags,
        :alert_type => @alert_type,
        :aggregation_key => @aggregation_key,
        :source_type_name => @source_type_name
      ))
      # for debug
      #puts "debug_out: #{@api_key} - #{event_key} - #{event_msg} - #{options} - #{@source_type_name} \n"
      #puts "debug_out: #{res}\n"
    end

  end
end
