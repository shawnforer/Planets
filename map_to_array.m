function [array] = map_to_array(map)
rows = size(map.grid, 1);
columns = size(map.grid, 2);
array = sparse(columns * rows, columns * rows);
for i = 1 : columns * rows
    if (isinf(map.grid(i)))
        continue
    end
    %Checks the cell directly below your current cell
    if (~isinf(map.grid(mod(i + columns * rows, columns * rows) + 1)))
        %If you are not in the bottom row
        if(mod(i, rows) ~= 0)
            array(i, i + 1) = 1;
        %If you are in the bottom row
        else
            array(i, i - rows + 1) = 1;
        end
    end
    %Checks the cell directly to th right of your current cell
    if (~isinf(map.grid(mod(i + rows - 1, columns * rows) + 1)))
        %If you are not in far right
        if(i <= columns * rows - rows)
            array(i, i + rows) = 1;
        %If you are in far right 
        else
            array(i, i - rows * (columns - 1)) = 1;
        end
    end
end
%Assume that if cell 1 is connected to 2, 2 is connected to 1
array = array  + array';
end
