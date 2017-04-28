function [index_below] = cell_below(index, rows, columns)
%This function takes the linear index of your current cell, and size of the map (rows, columns), 
%and retuns the linear index of the cell directly below it. 
index_below = (floor((index-1)/rows)) * rows + mod(index, rows)+1;
end
