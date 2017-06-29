function global_coverage = compute_global_coverage(Out)

% Compute global coverage based on cell occupancy method
% Out = data to test. Must be a StatFalsify object

N = length(Out.nominal_ranges) ;

Eps_grid_size = 4*ones(N,1) ; % line 54 of file PTC_Demo

sum_log = 0 ;

for i=1:N
    bi_ai = Out.nominal_ranges(i,2)-Out.nominal_ranges(i,1) ;
    sum_log = sum_log + (log(bi_ai)/Eps_grid_size(i)) ;
end

global_coverage = log(Out.num_samples) / (sum_log) ; 

