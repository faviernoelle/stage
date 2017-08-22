function [rank, region, line, value] = sort_robustness(Out) 

% [region, line, value] = get_min_rob(Out)
% Out = data to study. Must be a StatFalsify object
% register the position of the point with the lowest robustness (in which 
% rectangle it is and at which line) and its value. 
% rank = is the initial line of the data (if line 3 of rank = 8 it means
% that in Out, line 8 (of the rectangle with the lowest robustness)
% is the third lowest robustness
% line give the point with the lowest robustness in each rectangle


% Create table full of 1 for robustness and full of 0 for region, line and
% value
rob_val = 1 ;
rob = ones(numel(Out.regions),1) ;
% region = zeros(numel(Out.regions),1) ; 
% line = zeros(numel(Out.regions),1) ;
value = zeros(numel(Out.regions),1) ;


% For each rectangle
for i = 1 : numel(Out.regions) 

    % For each signal
    for j=1 : length(Out.clusters{i}.vals)
        % If the value of robustness is lower than the previous lowest
        % value, register this value as the value with lowest robustness 
        % and register its position (in which rectangle it is and at which
        % line)
        if Out.clusters{i}.vals(j)<rob_val
            region = i ; 
            line = j ;
            rob_val = Out.clusters{i}.vals(j);
        end
    end 
end

% put values or robustness of the rectangle with the lowest robustness in
% rob.
for j=1 : length(Out.clusters{region}.vals)
            rob(j) = Out.clusters{region}.vals(j) ; 
end


% Sort the value of the region with the lowest robustness by ascending 
% order of robustness
[value, rank] = sort(rob) ;


