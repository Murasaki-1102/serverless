{"filter":false,"title":"handler.rb","tooltip":"/sls-sample/handler.rb","undoManager":{"mark":0,"position":0,"stack":[[{"start":{"row":0,"column":0},"end":{"row":11,"column":0},"action":"remove","lines":["require 'json'","","def hello(event:, context:)","  {","    statusCode: 200,","    body: {","      message: 'Go Serverless v1.0! Your function executed successfully!',","      input: event","    }.to_json","  }","end",""],"id":2},{"start":{"row":0,"column":0},"end":{"row":102,"column":3},"action":"insert","lines":["require \"aws-record\"","require \"json\"","","def ping(event:, context:)","  {","    statusCode: 200,","    body: {","      message: \"hello serverless rest api!\"","    }.to_json","  }","end","","def list(event:, context:)","  list = DynamoTable.list_item","  {","    statusCode: 200,","    body: list.to_json","  }","end","","def get(event:, context:)","  id = event[\"pathParameters\"][\"id\"]","  item = DynamoTable.get_item(id: id)","  {","    statusCode: 200,","    body: item.to_json","  }","end","","def create(event:, context:)","  item = DynamoTable.put_item(body: JSON.parse(event[\"body\"]))","  {","    statusCode: 200,","    body: item.to_json","  }","end","","def update(event:, context:)","  id = event[\"pathParameters\"][\"id\"]","  DynamoTable.update_item(id: id, body: JSON.parse(event[\"body\"]))","  {","    statusCode: 200,","    body: {results: :success}.to_json","  }","end","","def delete(event:, context:)","  id = event[\"pathParameters\"][\"id\"]","  DynamoTable.delete_item(id: id)","  {","    statusCode: 200,","    body: {results: :success}.to_json","  }","end","","class DynamoTable","  include Aws::Record","  set_table_name ENV[\"DDB_TABLE\"]","  string_attr :id, hash_key: true","  string_attr :title","  string_attr :desc","  integer_attr :status","  epoch_time_attr :created_at","  epoch_time_attr :updated_at","","  def self.put_item(body:)","    time_now = Time.now.to_i","    item = new(","      id: SecureRandom.uuid,","      title: body[\"title\"],","      desc: body[\"desc\"],","      status: body[\"status\"],","      created_at: time_now,","      updated_at: time_now","    )","    item.save!","    item.to_h","  end","","  def self.update_item(id:, body:)","    update_opts = {id: id, updated_at: Time.now.to_i}","    [:title, :desc, :status].each do |k|","      update_opts[k] = body[k.to_s] if body[k.to_s]","    end","    update(update_opts)","  end","","  def self.get_item(id:)","    find(id: id).to_h","  end","","  def self.delete_item(id:)","    find(id: id).delete!","  end","","  def self.list_item","    res = []","    scan.each do |item|","      res << item.to_h","    end","    res","  end","end"]}]]},"ace":{"folds":[],"scrolltop":1014.0625,"scrollleft":0,"selection":{"start":{"row":102,"column":3},"end":{"row":102,"column":3},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1574693725333,"hash":"574cab943fe5f9a9c131ad41563c71d1ea2a9119"}