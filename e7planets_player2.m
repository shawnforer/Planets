function [where] = e7planets_player2(map)
rows = size(map.grid, 1);
columns = size(map.grid, 2);
Z = zeros(rows, columns); %%%%
location_scrap = map.scraps(1).location;
location_player = map.player.location(end, :);
scrap_row = location_scrap(1);
scrap_column = location_scrap(2);
player_row = location_player(1);
player_column = location_player(2);
player_location = player_row + (player_column - 1) * rows;
[distance_from_scrap, num] = wrapper(map);
disp(num)
topValue = distance_from_scrap(((floor((player_location-1)/rows))-floor((player_location-2)/rows))*rows + mod(player_location - 1, rows) + (floor((player_location-1)/rows))*rows);
botValue = distance_from_scrap((floor((player_location-1)/rows)) * rows + mod(player_location, rows)+1);
rightValue = distance_from_scrap((mod(player_location + rows - 1, columns * rows) + 1));
leftValue = distance_from_scrap((mod(player_location-rows-1, columns * rows)+1));
distances = [topValue, botValue, rightValue, leftValue];
%added in by shawn
%tells you if there are ghosts present, and how many

num_of_ghosts = size(map.ghosts(), 1);
%run through loop to check ghosts location vs. your location
%if the same, dont move in that direction
if(num_of_ghosts == 0 || min(distances) == 0)
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

contenders = distances .* (distances == min(distances));
disp(contenders);
top_distance = closest_ghost_distance(cell_above(player_location, rows, columns), rows, columns, map);
bot_distance = closest_ghost_distance(cell_below(player_location, rows, columns), rows, columns, map);
right_distance = closest_ghost_distance(cell_right(player_location, rows, columns), rows, columns, map);
left_distance = closest_ghost_distance(cell_left(player_location, rows, columns), rows, columns, map);
ghost_distances = [top_distance, bot_distance, right_distance, left_distance];
distance_final = contenders .* ghost_distances;
disp(distance_final);

if (distance_final(1) == max(distance_final))
    disp('hi');
    for g = 1:num_of_ghosts
        ghost_location = sub2ind(size(Z), map.ghosts(g).location(end,1), map.ghosts(g).location(end,2));
        top_location = cell_above(player_location, rows, columns);
        top_left_location = cell_left(top_location, rows, columns);
        top_right_location = cell_right(top_location, rows, columns);
        top_above_location = cell_above(top_location, rows, columns);
        if (ghost_location == top_location || ghost_location == ...
                top_left_location || ghost_location == top_right_location ...
                || ghost_location == top_above_location)
            break
        else
            where = 'U';
            return
        end
    end
elseif (distance_final(2) == max(distance_final))
    disp('hi2');
    for g = 1:num_of_ghosts
        ghost_location = sub2ind(size(Z), map.ghosts(g).location(end,1), map.ghosts(g).location(end,2));
        bot_location = cell_below(player_location, rows, columns);
        bot_left_location = cell_left(bot_location, rows, columns);
        bot_right_location = cell_right(bot_location, rows, columns);
        bot_below_location = cell_below(bot_location, rows, columns);
        if (ghost_location == bot_location || ghost_location == ...
                bot_left_location || ghost_location == bot_right_location ...
                || ghost_location == bot_below_location)
            break
        else
            where = 'D';
            return
        end
    end
elseif (distance_final(3) == max(distance_final))
    disp('hi3');
    for g = 1:num_of_ghosts
        ghost_location = sub2ind(size(Z), map.ghosts(g).location(end,1), map.ghosts(g).location(end,2));
        right_location = cell_right(player_location, rows, columns);
        right_right_location = cell_right(right_location, rows, columns);
        right_up_location = cell_above(right_location, rows, columns);
        right_down_location = cell_below(right_location, rows, columns);
        if (ghost_location == right_location || ghost_location == ...
                right_right_location || ghost_location == right_up_location ...
                || ghost_location == right_down_location)
            break
        else
            where = 'R';
            return
        end
    end
elseif (distance_final(4) == max(distance_final))
    disp('hi4');
    for g = 1:num_of_ghosts
        ghost_location = sub2ind(size(Z), map.ghosts(g).location(end,1), map.ghosts(g).location(end,2));
        left_location = cell_left(player_location, rows, columns);
        left_left_location = cell_left(left_location, rows, columns);
        left_up_location = cell_above(left_location, rows, columns);
        left_down_location = cell_below(left_location, rows, columns);
        if (ghost_location == left_location || ghost_location == ...
                left_left_location || ghost_location == left_up_location ...
                || ghost_location == left_down_location)
            break
        else
            where = 'L';
            return
        end
    end
else
    disp('hi5');
    where = '.';
    return
end
where = '.';
end
