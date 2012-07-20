# -*- encoding : utf-8 -*-
if ENV['MONGOHQ_URL'] then
  MongoMapper.config = { 
   Rails.env => { 'uri' => ENV['MONGOHQ_URL'] } }
  MongoMapper.connect(Rails.env)
else
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
  MongoMapper.database = "#mytaskboard-#{Rails.env}"
end
