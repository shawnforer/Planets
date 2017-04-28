function [min_distance] = closest_ghost_distance(index, rows, columns, map)
%This function calculates how far away the closest ghost is located in relation to the player's current location. 

Z = zeros(rows, columns); 
%Convert i,j index of current player location to linear index.
[player_row, player_col] = ind2sub(size(Z), index);
num_of_ghosts = size(map.ghosts(), 1);
ghost_location = zeros(2, num_of_ghosts);
%create an array which specifies the current location of each ghost on the map.
for g = 1:num_of_ghosts
    ghost_location(1, g) = map.ghosts(g).location(end, 1);
    ghost_location(2, g) = map.ghosts(g).location(end, 2);
end
distance = zeros(1, num_of_ghosts);
%Create an array which calculates the distance from the ghost's current location to the player's current location. 
for i = 1 : num_of_ghosts
    distance(i) = abs((ghost_location(1, i) - player_row)) + abs((ghost_location(2, i) - player_col));
end
%find which ghost is located the closest to the player. 
min_distance = min(distance);
end
