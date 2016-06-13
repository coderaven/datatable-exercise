# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Quick to_hash helper
include ApplicationHelper

def generate_random_object_changes
	types = [1,2,3]
	object_changes = ""
	rand(1..3).times do
		types = types.shuffle
		object_changes << "property#{types.delete_at(0)}:random value#{rand(1..100)},"
	end
	object_changes
end

ObjectRecord.destroy_all

ObjectRecord.create!([{
  object_id: 1,
  object_type: "ObjectA",
  timestamp: 412351252,
  object_changes: {property1: "value1", property3: "value2"}
},
{
  object_id: 1,
  object_type: "ObjectB",
  timestamp: 456662343,
  object_changes: {property1: "another value1"}
},
{
  object_id: 1,
  object_type: "ObjectA",
  timestamp: 467765765,
  object_changes: {property1: "altered value1", property2: "random value2"}
},{
  object_id: 2,
  object_type: "ObjectA",
  timestamp: 451232123,
  object_changes: {property2: "some value2"}
}])

p "Created #{ObjectRecord.count} default object records"



100.times do
  ObjectRecord.create!(object_id: rand(1..50),
                object_type: "Object" + ["A","B","C"].sample,
                timestamp: rand(Chronic.parse("2000-01-01 10:30:00")..Chronic.parse("2016-06-10 07:10:00")).to_i,
                object_changes: generate_hash(generate_random_object_changes))
end


p "Generated random #{ObjectRecord.count} object records"
