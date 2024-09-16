# frozen_string_literal: true

RSpec.describe CustomerioAPI::Object do
  subject { described_class }

  context 'initialize' do
    let(:attributes) { { 'email' => 'test@example.com', 'id' => '1', 'cio_id' => 'd7a90a000102' } }

    it 'is an OpenStruct' do
      expect(subject.new(attributes)).to be_a(OpenStruct)
    end
  end
end
