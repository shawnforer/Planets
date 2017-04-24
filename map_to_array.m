function [array] = map_to_array(map)
rows = size(map.grid, 1);
columns = size(map.grid, 2);
array = sparse(columns * rows, columns * rows);
for i = 1 : columns * rows
    if (isinf(map.grid(i)))
        continue
    end
    if (~isinf(map.grid(mod(i + columns * rows, columns * rows) + 1)))
        if(mod(i, rows) ~= 0)
            array(i, i + 1) = 1;
        else
            array(i, i - rows + 1) = 1;
        end
    end
    if (~isinf(map.grid(mod(i + rows - 1, columns * rows) + 1)))
        if(i <= columns * rows - rows)
            array(i, i + rows) = 1;
        else
            array(i, i - rows * (columns - 1)) = 1;
        end
    end
end
array = array  + array';
end
