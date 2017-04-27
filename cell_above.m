function [index_above] = cell_above(index, rows, columns)
index_above = ((floor((index-1)/rows))-floor((index-2)/rows))*rows + mod(index - 1, rows) + (floor((index - 1)/rows))*rows;
end
