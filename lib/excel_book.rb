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
				book_hash[sheet.name] = sheet_to_json_array(sheet)
				sheet_count += 1
			end
debugger
			return book_hash
		end

		def sheet_to_json_array(sheet)
			first_used_row, first_unused_row, first_used_col, first_unused_col = sheet.dimensions
			# sheet_hash = Hash.new
			# sheet_hash[sheet.name] = Array.new
			row_array = Array.new #sheet_hash[sheet.name]
			header_array = sheet.row(first_used_row).to_a

			header_count = 0
			((first_used_row+1)..first_unused_row-1).each do |row_index|
				row = sheet.row(row_index)
				row_array << Hash.new
				(first_used_col..first_unused_col-1).each do |col_index|
					row_array.last[header_array[header_count]] = row[col_index]
					header_count += 1
				end

				header_count = 0
			end

			return row_array
		end
end