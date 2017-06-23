function plot_rectangles_and_colore_selected_one(out,i,j,col)

% plot_rectangles_and_colore_selected_one(out,i,j,col)
% out = data to plot. Must be in a structure named DATA and the elements in
% DATA must be statFalsify structures
% i = values of dimension projection used on x
% j = values of dimension projection used on y
% col = rectangle selected. The points in this rectangle will be filled and
% the edge of this rectangle will be coloured


% Value to enter in rectangle with propriety 'position' :
% [x,y,w,h]
% x = left bottom corner of the rectangle on x
% y = left bottom corner of the rectangle on y
% w = width of the rectangle
% h = height of the rectangle

% Initial rectangle which contains the other ones
rect_init = rectangle('position',[0,0,40,40]) ;
set(rect_init, 'EdgeColor', [1, 1, 1])
hold on

% Création automatique du nombre de rectangles 

for k = 1:numel(out.regions)

    
    rectangle('position',[out.regions{k}(i,1),out.regions{k}(j,1), ...
        (out.regions{k}(i,2)-out.regions{k}(i,1)),...
        (out.regions{k}(j,2)-out.regions{k}(j,1))]) ;

end

rect_H = rectangle('position',[out.regions{col}(i,1),out.regions{col}(j,1), ...
    (out.regions{col}(i,2)-out.regions{col}(i,1)),...
    (out.regions{col}(j,2)-out.regions{col}(j,1))]) ;
set(rect_H, 'edgeColor', [1 0 0])


% Définition of color used to plot
colormap(jet_inverted)

x = NaN(10 * numel(out.clusters{1}.pts(:,1)),numel(out.regions)) ;
y = NaN(10 * numel(out.clusters{1}.pts(:,1)),numel(out.regions)) ;
c = NaN(10 * numel(out.clusters{1}.pts(:,1)),numel(out.regions)) ;

for h = 1 : numel(out.regions)
    for g = 1 : numel(out.clusters{h}.pts(:,1))
        x(g,h) = out.clusters{h}.pts(g,i) ;
        y(g,h) = out.clusters{h}.pts(g,j) ;
        c(g,h) = out.clusters{h}.vals(g)  ;
    end
    if h == col
        scatter(x(:,h),y(:,h),[],c(:,h),'filled')
    else 
        scatter(x(:,h),y(:,h),[],c(:,h))
    end
    
end


xlabel(['Projection dimension ', num2str(i)])
ylabel(['Projection dimension ', num2str(j)])
title(['Rectangles for x = ' num2str(i) ', y = ' num2str(j)])


% add colorbar
colorbar('')

hold off