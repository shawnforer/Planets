function [distance_from_player, scrap_number] = wrapper(map)
tic
rows = size(map.grid, 1);
columns = size(map.grid, 2);
distance_from_player = zeros(rows, columns);
num_scrap = size(map.scraps, 1);
distances = zeros(num_scrap + 1);
scrap_locations = zeros(1, num_scrap);
for i = 1 : num_scrap
    scrap_locations(i) = map.scraps(i).location(1) + (map.scraps(i).location(2) - 1) * rows;
end
player_location = map.player.location(end, 1) + (map.player.location(end, 2) - 1) * rows;
for i = 0 : num_scrap
    if (i == 0)
        data = dijkstra(map_to_array(map), map_to_array(map), scrap_locations(1));
        data2 = data;
    else
        data = dijkstra(map_to_array(map), map_to_array(map), scrap_locations(i));
    end
    for j = 0 : num_scrap
        if (i == j)
            distances(i + 1, j + 1) = NaN;
        elseif (j == 0)
            distances(i + 1, j + 1) = data(player_location);
        else
            distances(i + 1, j + 1) = data(scrap_locations(j));
        end
    end
end
for i = 1 : rows
    for j = 1 : columns
        distance_from_player(i, j) = data2(i + (j - 1) * rows);
    end
end
closest_scrap_index = find(distances(1, :) == min(distances(1, :)));
scrap_number = closest_scrap_index(1) - 1;
toc
end
