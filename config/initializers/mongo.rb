# -*- encoding : utf-8 -*-
if ENV['MONGOLAB_URI'] then
  MongoMapper.config = { 
    Rails.env => { 'uri' => ENV['MONGOLAB_URI'] } }
  MongoMapper.connect(Rails.env)
else
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
  MongoMapper.database = "#mytaskboard-#{Rails.env}"
end
