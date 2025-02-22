# frozen_string_literal: true

# Karafka should allow for nice subscription groups management style with nesting DSL

setup_karafka

draw_routes do
  subscription_group 'group1' do
    topic 'topic1' do
      consumer Class.new
    end
  end

  topic 'topic2' do
    consumer Class.new
  end

  subscription_group 'group2' do
    topic 'topic3' do
      consumer Class.new
    end
  end
end

subscription_groups = Karafka::App.subscription_groups.values.flatten

assert_equal 1, Karafka::App.routes.size
assert_equal 1, Karafka::App.consumer_groups.size
assert_equal 3, subscription_groups.size
assert_equal 3, Karafka::App.consumer_groups.first.topics.size
assert_equal 'topic1', Karafka::App.consumer_groups.first.topics.first.name
assert_equal 'topic2', Karafka::App.consumer_groups.first.topics[1].name
assert_equal 'topic3', Karafka::App.consumer_groups.first.topics[2].name
assert_equal 'group1', subscription_groups.first.topics.first.subscription_group.name
assert !subscription_groups[1].topics.first.subscription_group.nil?
assert_equal 'group2', subscription_groups[2].topics.first.subscription_group.name
