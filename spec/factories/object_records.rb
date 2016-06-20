FactoryGirl.define do
	factory :object_record do
		add_attribute :object_id, 1 # Needed to do this, ruby has object_id as built-in method
		object_type	"ObjectA"
		timestamp 1465748715
		object_changes ({property1: "val1"})
	end
end