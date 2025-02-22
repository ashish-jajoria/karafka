# frozen_string_literal: true

RSpec.describe_current do
  subject(:callback) { described_class.new(subscription_group_id, consumer_group_id) }

  let(:subscription_group_id) { SecureRandom.hex(6) }
  let(:consumer_group_id) { SecureRandom.hex(6) }
  let(:tpl) { rand }

  before { allow(::Karafka.monitor).to receive(:instrument) }

  describe '#on_partitions_revoke' do
    before { callback.on_partitions_revoke(tpl) }

    it 'expect to publish appropriate event' do
      expect(::Karafka.monitor).to have_received(:instrument).with(
        'rebalance.partitions_revoke',
        caller: callback,
        subscription_group_id: subscription_group_id,
        consumer_group_id: consumer_group_id,
        tpl: tpl
      )
    end
  end

  describe '#on_partitions_assign' do
    before { callback.on_partitions_assign(tpl) }

    it 'expect to publish appropriate event' do
      expect(::Karafka.monitor).to have_received(:instrument).with(
        'rebalance.partitions_assign',
        caller: callback,
        subscription_group_id: subscription_group_id,
        consumer_group_id: consumer_group_id,
        tpl: tpl
      )
    end
  end

  describe '#on_partitions_revoked' do
    before { callback.on_partitions_revoked(tpl) }

    it 'expect to publish appropriate event' do
      expect(::Karafka.monitor).to have_received(:instrument).with(
        'rebalance.partitions_revoked',
        caller: callback,
        subscription_group_id: subscription_group_id,
        consumer_group_id: consumer_group_id,
        tpl: tpl
      )
    end
  end

  describe '#on_partitions_assigned' do
    before { callback.on_partitions_assigned(tpl) }

    it 'expect to publish appropriate event' do
      expect(::Karafka.monitor).to have_received(:instrument).with(
        'rebalance.partitions_assigned',
        caller: callback,
        subscription_group_id: subscription_group_id,
        consumer_group_id: consumer_group_id,
        tpl: tpl
      )
    end
  end
end
