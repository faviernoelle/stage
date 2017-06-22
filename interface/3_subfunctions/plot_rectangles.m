function plot_rectangles(out,i,j)

% plot_rectangles(out,i,j)
% out = data to plot. Must be in a structure named DATA and the elements in
% DATA must be statFalsify structures
% i = values of dimension projection used on x
% j = values of dimension projection used on y


% Value to enter in rectangle with propriety 'position' :
% [x,y,w,h]
% x = left bottom corner of the rectangle on x
% y = left bottom corner of the rectangle on y
% w = width of the rectangle
% h = height of the rectangle

% Initial rectangle which contains the other ones
rectangle('position',[0,0,40,40])
hold on

% Création automatique du nombre de rectangles 

for k = 1:numel(out.regions)
  rectangle('position',[out.regions{k}(i,1),out.regions{k}(j,1), ...
     (out.regions{k}(i,2)-out.regions{k}(i,1)),...
     (out.regions{k}(j,2)-out.regions{k}(j,1))])
 
text((out.regions{k}(i,2) - out.regions{k}(i,1)) / 2 + out.regions{k}(i,1),...
    ( out.regions{k}(j,2) - out.regions{k}(j,1)) / 2 + out.regions{k}(j,1),...
    ['zone ' num2str(k)])
text((out.regions{k}(i,2) - out.regions{k}(i,1)) / 2 + out.regions{k}(i,1),...
    ( out.regions{k}(j,2) - out.regions{k}(j,1)) / 2 + out.regions{k}(j,1) -1,...
    ['Size/x = ' num2str(out.regions{k}(i,:))])
text((out.regions{k}(i,2) - out.regions{k}(i,1)) / 2 + out.regions{k}(i,1),...
    ( out.regions{k}(j,2) - out.regions{k}(j,1)) / 2 + out.regions{k}(j,1) -2, ...
    ['Size/y = ' num2str(out.regions{k}(j,:))])  

end


% Définition of color used to plot
colormap(jet_inverted)


for h = 1 : numel(out.regions)
    for g = 1 : numel(out.clusters{h}.pts(:,1))
        x(g,1) = out.clusters{h}.pts(g,i) ;
        y(g,1) = out.clusters{h}.pts(g,j) ;
        c(g,1) = out.clusters{h}.vals(g)  ;
    end
    scatter(x(:),y(:),[],c(:))
end


xlabel(['Projection dimension ', num2str(i)])
ylabel(['Projection dimension ', num2str(j)])
title(['Rectangle for x = ' num2str(i) ', y = ' num2str(j)])


% add colorbar
colorbar('')

hold off
