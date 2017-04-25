function [costs,paths] = dijkstra(AorV,xyCorE,SID,FID,showWaitbar)
tic;
narginchk(2,5);
% Process inputs
[n,nc] = size(AorV);
[m,mc] = size(xyCorE);
L = length(SID);
FID = (1:n);
M = length(FID);

E = a2e(AorV);
cost = xyCorE;


% Initialize output variables
L = length(SID);
M = length(FID);
costs = zeros(L,M);
paths = num2cell(NaN(L,M));

% Find the minimum costs and paths using Dijkstra's Algorithm

% Initializations
iTable = NaN(n,1);
minCost = Inf(n,1);
isSettled = false(n,1);
path = num2cell(NaN(n,1));
I = 1;
minCost(1) = 0;
iTable(1) = 0;
isSettled(1) = true;
path(1) = {1};
count = 0;
% Execute Dijkstra's Algorithm for this vertex
while any(~isSettled(FID))
    % Update the table
    jTable = iTable;
    iTable(I) = NaN;
    nodeIndex = find(E(:,1) == I);
    
    % Calculate the costs to the neighbor nodes and record paths
    for kk = 1:length(nodeIndex)
        J = E(nodeIndex(kk),2);
        if ~isSettled(J)
            c = cost(I,J);
            empty = isnan(jTable(J));
            if empty || (jTable(J) > (jTable(I) + c))
                iTable(J) = jTable(I) + c;
                path{J} = [path{I} J];
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
        I = K(N);
        minCost(I) = iTable(I);
        isSettled(I) = true;
    end
end

% Store costs and paths
costs(1,:) = minCost(FID);
paths(1,:) = path(FID);

% Pass the path as an array if only one source/destination were given
if L == 1 && M == 1
    paths = paths{1};
end
toc
end

% Convert adjacency matrix to edge list
function E = a2e(A)
[I,J] = find(A);
E = [I J];
end
