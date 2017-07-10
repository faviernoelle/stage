function global_coverage = compute_global_coverage(Out, PARAM)

% Compute global coverage based on cell occupancy method
% Out = data to test. Must be a StatFalsify object

N = PARAM.Nb_point ;

Eps_grid_size = PARAM.Grid_discretisation ; 


sum_log = 0 ;

for i=1:N
    bi_ai = Out.nominal_ranges(i,2)-Out.nominal_ranges(i,1) ;
    
    % formula to compute the coverage based on cell occupancy method
    sum_log = sum_log + (log(bi_ai)/Eps_grid_size(i)) ;
end

global_coverage = log(Out.num_samples) / (sum_log) ; 

