require 'minitest/spec'
require 'minitest/autorun'

require "mocha/setup"

module TestHelper

  def simple_rental_json
   '{"name":"Paradise Inn", "rate":"$250", "cleaning fee":"$120"}'
  end

  def complex_rental
  '
  {
      "name":"Fern Grove Lodge",
      "seasons":[
         {
            "one":{
               "start":"05-01",
               "end":"05-13",
               "rate":"$137"
            }
         },
         {
            "two":{
               "start":"05-14",
               "end":"04-30",
               "rate":"$220"
            }
         }
      ],
      "cleaning fee":"$98"
   }'    
  end

end

