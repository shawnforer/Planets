function [min_distance] = closest_ghost_distance(index, rows, columns, map)
Z = zeros(rows, columns); %%%%
[player_row, player_col] = ind2sub(size(Z), index);
num_of_ghosts = size(map.ghosts(), 1);
ghost_location = zeros(2, num_of_ghosts);
for g = 1:num_of_ghosts
    ghost_location(1, g) = map.ghosts(g).location(end, 1);
    ghost_location(2, g) = map.ghosts(g).location(end, 2);
end
distance = zeros(1, num_of_ghosts);
for i = 1 : num_of_ghosts
    distance(i) = abs((ghost_location(1, i) - player_row)) + abs((ghost_location(2, i) - player_col));
end
min_distance = min(distance);
end
