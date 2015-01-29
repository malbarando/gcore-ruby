require 'json'
require 'rest-client'
require 'gcore/api/exceptions'

module Gcore
  class Api
    class Stores
      class SalesOrderItems

        def self.create(params, attempts=1)
          endpoint = "#{Gcore::Api.endpoint}/stores/#{params[:store_id]}/sales_order_items"
          body = params[:body].to_json

          begin
            return {} if params.nil? || params.empty?

            JSON.parse(RestClient.post(endpoint,
              body,
              :content_type => :json,
              :accept => :json,
              :timeout => -1,
              :open_timeout => -1,
              :authorization => Gcore::Api.authorization), {symbolize_names: true})
          rescue StandardError => ex
            if attempts <= 10
              $stderr.puts "Gcore::Api::SalesOrderItems.create() failed - #{ex.message}. Trying again..."
              $stderr.puts "Method: POST"
              $stderr.puts "Endpoint: #{endpoint}"
              $stderr.puts "Body: #{body}"
              self.create(params, attempts + 1)
            else
              $stderr.puts "Gcore::Api::SalesOrderItems.create() failed - #{ex.message}. Cannot recover."
              return {}
            end
          end
        end


      end
    end
  end
end