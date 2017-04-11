function [where] = e7_planets_player(map)
location_scrap = map.scraps(1).location;
location_player = map.player.location(end, :);
scrap_row = location_scrap(1);
scrap_column = location_scrap(2);
player_row = location_player(1);
player_column = location_player(2);
if (scrap_row < player_row && ~isinf(map.grid(player_row - 1, player_column)))
    where = 'U';
    return
elseif (scrap_row > player_row && ~isinf(map.grid(player_row + 1, player_column)))
    where = 'D';
    return
elseif (scrap_column < player_column && ~isinf(map.grid(player_row, player_column - 1)))
    where = 'L';
    return
elseif (scrap_column > player_column && ~isinf(map.grid(player_row, player_column + 1)))
    where = 'R';
    return
end
where = '.';
%test
end
