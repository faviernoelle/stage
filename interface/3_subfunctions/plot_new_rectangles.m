function plot_new_rectangles(Out,i, j,column, PARAM)

% plot_rectangles(Out,i,j,column)
% Out = data to plot. Must be a statFalsify object
% i = values of dimension projection used on x
% j = values of dimension projection used on y
% column = rectangle selected. The points in this rectangle will be filled and
% the edge of this rectangle will be columnoured
% limits = table contening the limits of all dimensions of the data

% Value to enter in rectangle with propriety 'position' :
% [ x, y, w, h ]
% x = left bottom corner of the rectangle on x
% y = left bottom corner of the rectangle on y
% w = width of the rectangle
% h = height of the rectangle

limite_x = [PARAM.tab_dim(i,2) PARAM.tab_dim(i,3)] ;
limite_y = [PARAM.tab_dim(j,2) PARAM.tab_dim(j,3)] ;

% axis ([limite_x limite_y]) ;


% Initial rectangle which contains the other ones
rect_init = rectangle('position',[limite_x(1),...
    limite_y(1),limite_x(2)-limite_x(1),limite_y(2)-limite_y(1)]) ;
set(rect_init, 'Edgecolor', [1, 1, 1])
hold on

% Automatic creation of the number of rectangles
for k = 1:numel(Out.regions)
    rectangle('position',[Out.regions{k}(i,1), Out.regions{k}(j,1), ...
        (Out.regions{k}(i,2)-Out.regions{k}(i,1)),...
        (Out.regions{k}(j,2)-Out.regions{k}(j,1))]) ;
end


% columnoration of the edge of the rectangle selected
rect_H = rectangle('position',[Out.regions{column}(i,1),Out.regions{column}(j,1), ...
    (Out.regions{column}(i,2)-Out.regions{column}(i,1)),...
    (Out.regions{column}(j,2)-Out.regions{column}(j,1))]) ;
set(rect_H, 'edgecolor', [1 0 0])

% Définition of columnor used to plot
colormap(jet_inverted)

% Creation of a matrix x ten times bigger than the number maximal of point
% in on of the columnumn 
% The columnumn was choosen randomly so this is to ensure that enven if one
% columnumn is bigger x, y and c will still be large enougth
x = NaN(10 * numel(Out.clusters{1}.pts(:,1)),numel(Out.regions)) ;
y = NaN(10 * numel(Out.clusters{1}.pts(:,1)),numel(Out.regions)) ;
c = NaN(10 * numel(Out.clusters{1}.pts(:,1)),numel(Out.regions)) ;

% For each region
for h = 1 : numel(Out.regions)
    % for each columnumn 
    for g = 1 : numel(Out.clusters{h}.pts(:,1))
        % Put the values to plot in x and y and the value of robustness in
        % c
        
        if(Out.clusters{h}.pts(g,i)>limite_x(1) && ...
                Out.clusters{h}.pts(g,i)<limite_x(2) &&...
                Out.clusters{h}.pts(g,j)>limite_y(1) && ...
                Out.clusters{h}.pts(g,j)<limite_y(2))
        
            x(g,h) = Out.clusters{h}.pts(g,i) ;
            y(g,h) = Out.clusters{h}.pts(g,j) ;
            c(g,h) = Out.clusters{h}.vals(g)  ;
        end
    end
    if h == column
        % Plot the points of the selected rectangle filled
        scatter(x(:,h),y(:,h),[],c(:,h),'filled')
    else 
        % Point the other point not filled
        scatter(x(:,h),y(:,h),[],c(:,h))
    end
    
end


xlabel(['Projection dimension ', num2str(i)])
ylabel(['Projection dimension ', num2str(j)])
title(['Rectangles for x = ' num2str(i) ', y = ' num2str(j)])


% add columnorbar
colorbar('')

hold off