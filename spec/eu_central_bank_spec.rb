require 'rspec'
require 'webmock/rspec'
require 'money-distributed-eucb'

describe Money::Distributed::Fetcher::EuCentralBank do
  let(:bank) { double(add_rate: true) }

  let(:response) do
    File.read(File.expand_path('../fixtures/response.xml', __FILE__))
  end

  subject { described_class.new(bank) }

  before do
    stub_request(:get, described_class::ECB_RATES_URL)
      .to_return(status: 200, body: response)
  end

  it 'fetches rates from eu central bank' do
    subject.fetch

    # rubocop: disable Metrics/LineLength
    expect(bank).to have_received(:add_rate).with('EUR', 'EUR', BigDecimal('1.0'))
    expect(bank).to have_received(:add_rate).with('USD', 'USD', BigDecimal('1.0'))
    expect(bank).to have_received(:add_rate).with('AUD', 'AUD', BigDecimal('1.0'))
    expect(bank).to have_received(:add_rate).with('EUR', 'USD', BigDecimal('1.1146'))
    expect(bank).to have_received(:add_rate).with('USD', 'EUR', BigDecimal('0.8972'))
    expect(bank).to have_received(:add_rate).with('EUR', 'AUD', BigDecimal('1.5475'))
    expect(bank).to have_received(:add_rate).with('AUD', 'EUR', BigDecimal('0.6462'))
    expect(bank).to have_received(:add_rate).with('USD', 'AUD', BigDecimal('1.3884'))
    expect(bank).to have_received(:add_rate).with('AUD', 'USD', BigDecimal('0.7203'))
    # rubocop: enable Metrics/LineLength
  end
end
