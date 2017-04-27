function [distance_from_closest_scrap, scrap_number_distance] = wrapper(map)
tic
rows = size(map.grid, 1);
columns = size(map.grid, 2);
distance_from_closest_scrap = zeros(rows, columns);
num_scrap = size(map.scraps, 1);
distances = zeros(num_scrap + 1);
scrap_locations = zeros(1, num_scrap + 1);
values = zeros(1, num_scrap);
for i = 1 : num_scrap
    scrap_locations(i) = map.scraps(i).location(1) + (map.scraps(i).location(2) - 1) * rows;
    values(i + 1) = map.scraps(i).value;
end
player_location = map.player.location(end, 1) + (map.player.location(end, 2) - 1) * rows;
for i = 0 : num_scrap
    if (i == 0)
        data = dijkstra(map_to_array(map), map_to_array(map), player_location);
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
disp(distances);
value_per_distance = values ./ distances
value_scrap_index = find(value_per_distance(1, :) == max(value_per_distance(1, :)));
scrap_num_value = value_scrap_index(1) - 1
closest_scrap_index = find(distances(1, :) == min(distances(1, :)));
scrap_number_distance = closest_scrap_index(1) - 1
data2 = dijkstra(map_to_array(map), map_to_array(map), scrap_locations(scrap_num_value));
for i = 1 : rows
    for j = 1 : columns
        distance_from_closest_scrap(i, j) = data2(i + (j - 1) * rows);
    end
end
toc
end
