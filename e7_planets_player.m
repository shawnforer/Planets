function [where] = e7planets_player(map)
rows = size(map.grid, 1);
cols = size(map.grid, 2);
location_scrap = map.scraps(1).location;
location_player = map.player.location(end, :);
scrap_row = location_scrap(1);
scrap_column = location_scrap(2);
player_row = location_player(1);
player_column = location_player(2);
i = player_row + (player_column - 1) * rows;
[distance_from_scrap, ~] = wrapper(map);
topValue = distance_from_scrap(((floor((i-1)/rows))-floor((i-2)/rows))*rows + mod(i - 1, rows) + (floor((i-1)/rows))*rows);
botValue = distance_from_scrap((floor((i-1)/rows)) * rows + mod(i, rows)+1);
rightValue = distance_from_scrap((mod(i + rows - 1, cols * rows) + 1));
leftValue = distance_from_scrap((mod(i-rows-1, cols * rows)+1));
distances = [topValue, botValue, rightValue, leftValue];
if (topValue == min(distances))
    where = 'U';
    return
elseif (botValue == min(distances))
    where = 'D';
    return
elseif (rightValue == min(distances))
    where = 'R';
    return
elseif (leftValue == min(distances))
    where = 'L';
    return
else
    where = '.';
    return
end
end
