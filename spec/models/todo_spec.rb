require 'spec_helper'

describe Todo do
	before do
		@todo = Todo.new
	end

  context "hello method" do
  	it "return hello string" do
  		expect(@todo.hello).to eq("hello")
  	end
  end

  context "spread_test method" do
  	it "return hello string" do
  		expect(@todo.spread_test).to eq("hello")
  	end
  end
end
