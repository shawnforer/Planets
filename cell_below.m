function [index_below] = cell_below(index, rows, columns)
index_below = (floor((index-1)/rows)) * rows + mod(index, rows)+1;
end
