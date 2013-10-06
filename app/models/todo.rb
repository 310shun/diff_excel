require 'excel_book'

class Todo < ActiveRecord::Base
	def hello
		return "hello"
	end

	def spread_test
		old_sheet = ExcelBook.new('public/test_data/spread_test_zure.xls')
		new_sheet = ExcelBook.new('public/test_data/spread_test_2_zure.xls')

		diff_zure = new_sheet - old_sheet
		diff_zure.save_json('public/diff_zure.json')
		return "hello"
	end
end
