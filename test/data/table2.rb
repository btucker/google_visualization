table = DataTable.new
table.add_column DataColumn.new(DataType::STRING, 'Name')
table.add_column DataColumn.new(DataType::NUMBER, 'Salary')
table.add_column DataColumn.new(DataType::BOOLEAN, 'Full Time Employee')
table.add_row ['Mike', DataCell.new(10000, '$10,000'), true]
table.add_row ['Jim', DataCell.new(8000, '$8,000'), false]
table.add_row ['Alice', DataCell.new(12500, '$12,500'), true]
table.add_row ['Bob', DataCell.new(7000, '$7,000'), true]