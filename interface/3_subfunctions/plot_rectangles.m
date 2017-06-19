function plot_rectangles(out,i,j)

% Value to enter in rectangle with propriety 'position' :
% [x,y,w,h]
% x = left bottom corner of the rectangle on x
% y = left bottom corner of the rectangle on y
% w = width of the rectangle
% h = height of the rectangle

% Initial rectangle which contains the other ones
rectangle('position',[0,0,40,40])
hold on


% Rectangle created from the first regions
rectangle('position',[out.regions{1}(i,1),out.regions{1}(j,1), ...
     (out.regions{1}(i,2)-out.regions{1}(i,1)),...
     (out.regions{1}(j,2)-out.regions{1}(j,1))])
% Write the numero of the zone at the specified zone which is juste above 
% and on the rigth of the bottom left of the rectangle
text(out.regions{1}(i,1)+5,out.regions{1}(j,1)+5,'zone1')


% Rectangle created from the segund regions
rectangle('position',[out.regions{2}(i,1),out.regions{2}(j,1), ...
     (out.regions{2}(i,2)-out.regions{2}(i,1)),...
     (out.regions{2}(j,2)-out.regions{2}(j,1))])
text(out.regions{2}(i,1)+5,out.regions{2}(j,1)+5,'zone2')


% Rectangle created from the third regions
rectangle('position',[out.regions{3}(i,1),out.regions{3}(j,1), ...
     (out.regions{3}(i,2)-out.regions{3}(i,1)),...
     (out.regions{3}(j,2)-out.regions{3}(j,1))])
text(out.regions{3}(i,1)+5,out.regions{3}(j,1)+5,'zone3')


% Rectangle created from the fourth regions
rectangle('position',[out.regions{4}(i,1),out.regions{4}(j,1), ...
     (out.regions{4}(i,2)-out.regions{4}(i,1)),...
     (out.regions{4}(j,2)-out.regions{4}(j,1))])
text(out.regions{4}(i,1)+5,out.regions{4}(j,1)+5,'zone4')


% Définition of color used to plot
colormap(jet_inverted)



% selection of the point to plot in the first rectangle
x1 = out.clusters{1}.pts(:,i);
y1 = out.clusters{1}.pts(:,j);
c1 = out.clusters{1}.vals(:) ;
scatter(x1,y1,[],c1)

% selection of the point to plot in the second rectangle
x2 = out.clusters{2}.pts(:,i);
y2 = out.clusters{2}.pts(:,j);
c2 = out.clusters{2}.vals(:) ;
scatter(x2,y2,[],c2) 

% selection of the point to plot in the third rectangle
x3 = out.clusters{3}.pts(:,i);
y3 = out.clusters{3}.pts(:,j);
c3 = out.clusters{3}.vals(:) ;
scatter(x3,y3,[],c3)

% selection of the point to plot in the forth rectangle
x4 = out.clusters{4}.pts(:,i);
y4 = out.clusters{4}.pts(:,j);
c4 = out.clusters{4}.vals(:) ;
scatter(x4,y4,[],c4)

% add colorbar
colorbar('')

hold off
