require 'excel_book'

class Todo < ActiveRecord::Base
	def hello
		return "hello"
	end

	def spread_test
		old_sheet = ExcelBook.new('public/spread_test.xls')
		return "hello"
	end
end
