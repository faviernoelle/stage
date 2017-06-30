function plot_rectangles(out,i,j,col)

% plot_rectangles(out,i,j,col)
% out = data to plot. Must be a statFalsify object
% i = values of dimension projection used on x
% j = values of dimension projection used on y
% col = rectangle selected. The points in this rectangle will be filled and
% the edge of this rectangle will be coloured


% Value to enter in rectangle with propriety 'position' :
% [ x, y, w, h ]
% x = left bottom corner of the rectangle on x
% y = left bottom corner of the rectangle on y
% w = width of the rectangle
% h = height of the rectangle

% Initial rectangle which contains the other ones
rect_init = rectangle('position',[0,0,40,40]) ;
set(rect_init, 'EdgeColor', [1, 1, 1])
hold on

% Automatic creation of the number of rectangles
for k = 1:numel(out.regions)
    rectangle('position',[out.regions{k}(i,1),out.regions{k}(j,1), ...
        (out.regions{k}(i,2)-out.regions{k}(i,1)),...
        (out.regions{k}(j,2)-out.regions{k}(j,1))]) ;
end


% Coloration of the edge of the rectangle selected
rect_H = rectangle('position',[out.regions{col}(i,1),out.regions{col}(j,1), ...
    (out.regions{col}(i,2)-out.regions{col}(i,1)),...
    (out.regions{col}(j,2)-out.regions{col}(j,1))]) ;
set(rect_H, 'edgeColor', [1 0 0])

% Définition of color used to plot
colormap(jet_inverted)

% Creation of a matrix x ten times bigger than the number maximal of point
% in on of the column 
% The column was choosen randomly so this is to ensure that enven if one
% column is bigger x, y and c will still be large enougth
x = NaN(10 * numel(out.clusters{1}.pts(:,1)),numel(out.regions)) ;
y = NaN(10 * numel(out.clusters{1}.pts(:,1)),numel(out.regions)) ;
c = NaN(10 * numel(out.clusters{1}.pts(:,1)),numel(out.regions)) ;

% For each region
for h = 1 : numel(out.regions)
    % for each column 
    for g = 1 : numel(out.clusters{h}.pts(:,1))
        % Put the values to plot in x and y and the value of robustness in
        % c
        x(g,h) = out.clusters{h}.pts(g,i) ;
        y(g,h) = out.clusters{h}.pts(g,j) ;
        c(g,h) = out.clusters{h}.vals(g)  ;
    end
    if h == col
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


% add colorbar
colorbar('')

hold off