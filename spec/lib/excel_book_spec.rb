require 'spec_helper'
require 'excel_book'

describe 'lib/excel_book' do
	before do
		@old_book = ExcelBook.new('public/spread_test.xls')
		@new_book = ExcelBook.new('public/spread_test_2.xls')
		@new_add_sheet_book = ExcelBook.new('public/spread_test_add_sheet.xls')
	end

	context "to_json method" do
		it "return correct json" do
			correct_json_string = '{"Sheet1":[{"id":1,"todo":"takos","due":2013},{"id":2,"todo":"tetsuya","due":2014},{"id":3,"todo":"bessa","due":2050}],"takos":[{"id":1,"name":"tyo","status":"valid"},{"id":2,"name":"wee","status":"valid"},{"id":3,"name":"qqq","status":"invalid"}]}'
			expect(@old_book.to_json).to eq(correct_json_string)
		end
	end

	context "- method" do
		it "return correct diff json" do
			diff_book = @new_book - @old_book
			correct_diff_json_string = '{"Sheet1":[{"id":3,"todo":"yasu","due":2050}],"takos":[{"id":2,"name":"wee","status":"invalid"},{"id":3,"name":"qqq","status":"valid"}]}'
			expect(diff_book.to_json).to eq(correct_diff_json_string)
		end

		it "return correct diff json where added sheet" do
			diff_book = @new_add_sheet_book - @old_book
			correct_diff_json_string = '{"Sheet1":[{"id":3,"todo":"yasu","due":2050}],"takos":[{"id":2,"name":"wee","status":"invalid"},{"id":3,"name":"qqq","status":"valid"}],"member":[{"id":1,"user_id":2,"notification":true},{"id":2,"user_id":4,"notification":false},{"id":3,"user_id":2,"notification":true}]}'
			expect(diff_book.to_json).to eq(correct_diff_json_string)
		end
	end

	context "save_json" do
		it "correct save json file" do
			@new_book.save_json('public/new_book.json')
			expect(File.exist?('public/new_book.json')).to be_true 
		end

		it "saved json is correct contents" do
			@new_book.save_json('public/new_book.json')
			json_string = File.read('public/new_book.json', encoding: Encoding::UTF_8)
			correct_json_string = '{"Sheet1":[{"id":1,"todo":"takos","due":2013},{"id":2,"todo":"tetsuya","due":2014},{"id":3,"todo":"yasu","due":2050}],"takos":[{"id":1,"name":"tyo","status":"valid"},{"id":2,"name":"wee","status":"invalid"},{"id":3,"name":"qqq","status":"valid"}]}'
			expect(json_string).to eq(correct_json_string)
		end
	end

	context "save_excel" do
		it "correct save excel file" do
			@new_book.save_excel("public/new_new.xls")
			expect(File.exist?('public/new_new.xls')).to be_true
		end
	end
end