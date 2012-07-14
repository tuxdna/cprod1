require 'pp'
require 'rubygems'
require 'mongo'
require 'singleton'
require 'config'

class Db
  include Singleton
  attr_accessor :products
  def initialize()
    @conn = Mongo::Connection.new(
                                  Config::DATABASE_HOST,
                                  Config::DATABASE_PORT,
                                  :pool_size => Config::DATABASE_POOL_SIZE,
                                  :pool_timeout => Config::DATABASE_TIME_OUT
                                  )
    @db = @conn[Config::DATABASE_NAME]
    @product_collection = @db['product']
  end

  def products
    @product_collection
  end
end

