require 'money-distributed'
require 'nokogiri'

class Money
  module Distributed
    module Fetcher
      # European Central Bank rates fetcher
      class EuCentralBank < Base
        ECB_RATES_URL =
          'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'.freeze
        RATE_XPATH = 'gesmes:Envelope/xmlns:Cube/xmlns:Cube//xmlns:Cube'.freeze

        private

        def exchange_rates
          doc = Nokogiri::XML(open(ECB_RATES_URL))
          doc.xpath(RATE_XPATH).each_with_object('EUR' => 1) do |node, h|
            h[node[:currency]] = BigDecimal.new(node[:rate])
          end
        end
      end
    end
  end
end
