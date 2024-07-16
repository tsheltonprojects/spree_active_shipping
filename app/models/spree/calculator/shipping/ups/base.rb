require_dependency 'spree/calculator'

module Spree
  module Calculator::Shipping
    module Ups
      class Base < Spree::Calculator::Shipping::ActiveShipping::Base
        def carrier
          carrier_details = {
            client_id: Spree::ActiveShipping::Config[:ups_client_id],
            client_secret: Spree::ActiveShipping::Config[:ups_client_secret],
            test: Spree::ActiveShipping::Config[:test_mode]
          }

          if shipper_number = Spree::ActiveShipping::Config[:shipper_number]
            carrier_details.merge!(origin_account: shipper_number)
          end

          ::ActiveShipping::UPS.new(carrier_details)
        end

        protected
        # weight limit in ounces http://www.ups.com/content/us/en/resources/prepare/oversize.html
        def max_weight_for_country(country)
          2400    # 150 lbs
        end
      end
    end
  end
end
