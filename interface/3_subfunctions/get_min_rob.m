function [region, line, value] = get_min_rob(Out) 

% [region, line, value] = get_min_rob(Out)
% Out = data to study. Must be a StatFalsify object
% register the position of the point with the lowest robustness (in which 
% rectangle it is and at which line) and its value. 

% Highest value of robustness 
rob = 1 ; 

% For each rectangle
for i = 1 : numel(Out.regions) 
    % For each signal
    for j=1 : length(Out.clusters{i}.vals)
        % If the value of robustness is lower than the previous lowest
        % value register this value as the value with lowest robustness and
        % register its position (in which rectangle it is and at which
        % line) and its value. 
        if Out.clusters{i}.vals(j)<rob
            rob = Out.clusters{i}.vals(j) ;
            region = i ; 
            line = j ;
            value = rob ;
        end
    end
end



