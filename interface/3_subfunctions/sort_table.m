function new_data = sort_table(data,column)

% new_data = sort_table(data,column)
% Sort data according to the column selected
% Data is a table of numbers that must be sorted
% Column is the column that will be used to sort the table. The values of
% this column will be sorted by ascending order
% new_data is the table with the data sorted

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