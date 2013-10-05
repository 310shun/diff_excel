require 'excel'

class ExcelBook < Excel
	def initialize(path)
		super(path)
		@book_hash = book_to_json_hash(path)
	end

	def -(other_book)

	end

	def save_json

	end

	def save_excel

	end


	private
		def book_to_json_hash(path)
			book = Spreadsheet.open(path)
			book_hash = Hash.new

			sheet_count = 0
			while book.worksheet(sheet_count)
				sheet = book.worksheet(sheet_count)
			end

			return book_hash
		end

		def sheet_to_json_hash

		end
end