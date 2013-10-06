require 'excel'

class ExcelBook < Excel
	def initialize(path)
		if path
			super(path)
			@book_hash = book_to_json_hash(path)
		end
	end

	def -(other_book)
		return ExcelBook.init_with_json(get_diff_book(other_book))
	end

	def to_json
		return @book_hash.to_json
	end

	def save_json(path)
		File.write(path, @book_hash.to_json)
	end

	def save_excel(path)
		saving_excel = get_spreadsheet
		saving_excel.write(path)
	end

	attr_accessor :book_hash

	private
		# @book_hashから、Spreadsheet::Workbookインスタンスを生成、それを返す
		def get_spreadsheet
			book = Spreadsheet::Workbook.new

			@book_hash.each do |sheet_name, rows|
				sheet = book.create_worksheet
				sheet.name = sheet_name
				set_sheet_rows!(sheet, rows)
			end

			return book
		end

		def set_sheet_rows!(sheet, rows)
			# header行を挿入
			sheet.row(0).concat(rows.first.keys)

			rows.each_with_index do |row, row_index|
				sheet.row(row_index+1).concat(row.values)
			end
		end

		def self.init_with_json(book_json)
			excel_book = ExcelBook.new(nil)
			excel_book.book_hash = book_json
			return excel_book
		end

		def get_diff_book(other_book)
			diff_book_hash = Hash.new
			other_book_hash = other_book.book_hash

			@book_hash.each do |sheet_name, rows|
				other_sheet_rows = other_book_hash[sheet_name]
				tmp_sheet_hash = Hash.new
				tmp_sheet_hash[sheet_name] = Array.new

				if other_sheet_rows
					# 同じ名前のシートが存在する場合
					diff_sheet = get_diff_sheet(sheet_name, rows, other_sheet_rows)
					diff_book_hash[sheet_name] = diff_sheet unless diff_sheet.size == 0
				else
					# 新しいシートが存在する場合
					diff_book_hash[sheet_name] = rows
				end
			end

			return diff_book_hash
		end

		# 異なる箇所の行配列を返す
		def get_diff_sheet(sheet_name, self_sheet_rows, other_sheet_rows)
			diff_array = Array.new

			self_sheet_rows.each_with_index do |row, index|
				if row != other_sheet_rows[index]
					diff_array << row
				end
			end

			return diff_array
		end

		def book_to_json_hash(path)
			book = Spreadsheet.open(path)
			book_hash = Hash.new

			sheet_count = 0
			while book.worksheet(sheet_count)
				sheet = book.worksheet(sheet_count)
				book_hash[sheet.name] = sheet_to_json_array(sheet)
				sheet_count += 1
			end

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