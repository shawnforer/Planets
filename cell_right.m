function [index_right] = cell_right(index, rows, columns)
%This function takes the linear index of your current cell, and size of the map (rows, columns), 
%and retuns the linear index of the cell directly to the right of the original. 
index_right = (mod(index + rows - 1, columns * rows) + 1);
end
