require 'spec_helper'
require 'excel_book'

describe 'lib/excel_book' do
	context "" do
		it "tekito" do
			@excel_book = ExcelBook.new('public/spread_test.xls')
			#expect("tako").to eq("tako")
		end
	end
end