table = DataTable.new
table.add_column DataColumn.new(DataType::STRING, 'Task')
table.add_column DataColumn.new(DataType::NUMBER, 'Hours per Day')
table.add_row ['Work', 11]
table.add_row ['Eat', 2]
table.add_row ['Commute', 2]
table.add_row ['Watch TV', 2]
table.add_row ['Sleep', 7]