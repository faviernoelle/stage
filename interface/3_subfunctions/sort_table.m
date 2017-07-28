function new_data = sort_table(data,column)

data_ref = data(:,column) ; 
new_data = zeros(numel(data_ref),3) ;

for i = 1:numel(data_ref)
    for j = 1:numel(data_ref)
        if data_ref(j) == i
            new_line = j ;
        end
    end
    new_data(i,:) = data(new_line,:) ;
end