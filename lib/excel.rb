class Excel
	def initialize(path)
		raise "file not found" unless File.exist?(path)
		@path = path
	end

	def -(other_book)
		# 必ず継承先でオーバライドしてください
	end

	def save_json
		raise "@book_hash is null" unless @book_hash
		# 必ず継承先でオーバライドしてください
	end

	def save_excel
		raise "@book_hash is null" unless @book_hash
		# 必ず継承先でオーバライドしてください
	end
end