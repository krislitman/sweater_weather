class Slug
  def self.[](slug)
    redis.hget(hash, slug)
  end

  def self.[]=(slug, id)
    redis.hset(hash, slug, id) 
  end

  private

  def self.redis
    $redis
  end

  def self.hash
    "ids"
  end
end