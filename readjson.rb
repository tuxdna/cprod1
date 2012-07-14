require 'rubygems'
require 'json'
require 'pp'
require 'db'

def parse(buf)
  # convert buf to json and store
  return if buf.length < 1
  s = buf[-1]
  s = s.sub(',', "") unless s.nil?
  buf[-1] = s
  str = "{ #{buf.join} }"
  j = JSON.load(str)
end

f = File.open("/data/dev/sansari/hacknight/cprod/TrainingSet/products.json", "r")
buf = []
inside_block = false
2.times {f.readline}

entries = 0
db = Db.instance
products = db.products
while ln = f.readline
  if ln['": [']
    j = parse(buf)
    products.insert(j) unless j.nil?
    inside_block = true
    buf = []
    entries +=1
    puts "#entries = #{entries}"
  end
  buf << ln
end

