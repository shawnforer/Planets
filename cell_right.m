function [index_right] = cell_right(index, rows, columns)
index_right = (mod(index + rows - 1, columns * rows) + 1);
end
