function [region, signal, value] = get_min_rob(Out) 

rob=1 ; 


for i=1 : 4 
    for j=1 : length(Out.clusters{i}.vals)
        if Out.clusters{i}.vals(j)<rob
            rob = Out.clusters{i}.vals(j) ;
            region = i ; 
            signal = j ;
            value = Out.clusters{i}.vals(j) ;
        end
    end
end



