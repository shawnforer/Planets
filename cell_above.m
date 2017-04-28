function [index_above] = cell_above(index, rows, columns)
%This function takes the linear index of your current cell, and size of the map (rows, columns), 
%and retuns the linear index of the cell directly above it. 
index_above = ((floor((index-1)/rows))-floor((index-2)/rows))*rows + mod(index - 1, rows) + (floor((index - 1)/rows))*rows;
end
