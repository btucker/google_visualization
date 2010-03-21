table = DataTable.new
table.store_custom_property(:foo, 'hello')
table.add_column DataColumn.new(DataType::STRING, 'A-label', 'A')
table.add_column DataColumn.new(DataType::NUMBER, 'B-label', 'B')
table.add_column DataColumn.new(DataType::DATE, 'C-label', 'C')
table.add_row ['a', DataCell.new(1.0, 'One'), DataCell.new(Date.parse("2000/01/01"), '01/01/2000')]
table.add_row ['b', DataCell.new(2.0, 'Two'), DataCell.new(Date.parse("2000/01/02"), '01/02/2000')]
table.add_row ['c', DataCell.new(3.0, 'Three'), DataCell.new(Date.parse("2000/01/03"), '01/03/2000')]