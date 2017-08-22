function [rank, line, value] = sort_robustness(Out) 

% [region, line, value] = get_min_rob(Out)
% Out = data to study. Must be a StatFalsify object 
% Give the position and the value of the point with the lowest robustness
% in each rectangle. Give also the rank of lowest robustness of each
% rectangle.
% rank = give the rank of lowest robustness for each rectangle (for intance
% if in the third rectangle there is the point with the lowest robustness
% of all points, line three of rank will be 1. )
% line = the line of the lowest robustness in each rectangle. 
% value = the value of the lowest robustness of each rectangle


% Create table full of 1 for robustness and full of 0 for region, line and
% value
rob = ones(numel(Out.regions),1) ; 
line = zeros(numel(Out.regions),1) ;
value = zeros(numel(Out.regions),1) ;

% For each rectangle
for i = 1 : numel(Out.regions) 

    % For each signal
    for j=1 : length(Out.clusters{i}.vals)
        % If the value of robustness is lower than the previous lowest
        % value register this value as the value with lowest robustness and
        % register its position (in which rectangle it is and at which
        % line) and its value. 
        if Out.clusters{i}.vals(j)<rob(i)
            rob(i) = Out.clusters{i}.vals(j) ;
            line(i) = j ;
            value(i) = rob(i) ;
        end
    end
end

% Sort the value of the region with the lowest robustness by ascending 
% order of robustness
[value, rank] = sort(value) ;

