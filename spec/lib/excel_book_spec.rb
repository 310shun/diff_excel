require 'spec_helper'
require 'excel_book'

describe 'lib/excel_book' do
	context "" do
		it "tekito" do
			old_book = ExcelBook.new('public/spread_test.xls')
			new_book = ExcelBook.new('public/spread_test_2.xls')
			diff_book = new_book - old_book
			#expect("tako").to eq("tako")
		end
	end
end