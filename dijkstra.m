function [costs,paths] = dijkstra(connections_boolean, connections_distances, start_cell, end_cell)
% Process inputs
[num_cells,~] = size(connections_boolean);
[~, ~] = size(connections_distances);
FID = (1 : num_cells);

E = a2e(connections_boolean);
cost = connections_distances;

% Initialize output variables
costs = zeros(1, num_cells);
paths = num2cell(NaN(1,num_cells));


% Find the minimum costs and paths using Dijkstra's Algorithm
% Initializations
iTable = NaN(num_cells,1);
minCost = Inf(num_cells,1);
isSettled = false(num_cells,1);
path = num2cell(NaN(num_cells,1));
index = start_cell;
minCost(index) = 0;
iTable(index) = 0;
isSettled(index) = true;
path(index) = {index};

% Execute Dijkstra's Algorithm for this vertex
while any(~isSettled(FID))
    
    % Update the table
    jTable = iTable;
    iTable(index) = NaN;
    nodeIndex = find(E(:,1) == index);
    
    % Calculate the costs to the neighbor nodes and record paths
    for kk = 1:length(nodeIndex)
        J = E(nodeIndex(kk),2);
        if ~isSettled(J)
            c = cost(index,J);
            empty = isnan(jTable(J));
            if empty || (jTable(J) > (jTable(index) + c))
                iTable(J) = jTable(index) + c;
                path{J} = [path{index} J];
            else
                iTable(J) = jTable(J);
            end
        end
    end
    
    % Find values in the table
    K = find(~isnan(iTable));
    if isempty(K)
        break
    else
        % Settle the minimum value in the table
        [~,N] = min(iTable(K));
        index = K(N);
        minCost(index) = iTable(index);
        isSettled(index) = true;
    end
end

% Store costs and paths
costs(1,:) = minCost(FID);
paths(1,:) = path(FID);
end

% Convert adjacency matrix to edge list
function E = a2e(A)
[I,J] = find(A);
E = [I J];
end
