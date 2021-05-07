$redis = Redis::Namespace.new("redis_with_rails", :redis => Redis.new)

unless Rails.env.test?
  REDIS = Redis::Namespace.new(:my_namespace,
  redis: Redis.new(host: Rails.application.config.redis_host, port: 6379, db: 0) )
else
  REDIS = Redis::Namespace.new(:my_namespace, redis: MockRedis.new )
end