function plot_rectangles(out,i,j)

% Value to enter in rectangle with propriety 'position' :
% [x,y,w,h]
% x = left bottom corner of the rectangle on x
% y = left bottom corner of the rectangle on y
% w = width of the rectangle
% h = height of the rectangle

% Initial rectangle which contains the other ones
figure()
rectangle('position',[0,0,40,40])
hold on
% Rectangle created from the first regions
rectangle('position',[out.regions{1}(i,1),out.regions{1}(j,1), ...
     (out.regions{1}(i,2)-out.regions{1}(i,1)),...
     (out.regions{1}(j,2)-out.regions{1}(j,1))])
 % Rectangle created from the segund regions
rectangle('position',[out.regions{2}(i,1),out.regions{2}(j,1), ...
     (out.regions{2}(i,2)-out.regions{2}(i,1)),...
     (out.regions{2}(j,2)-out.regions{2}(j,1))])
  % Rectangle created from the third regions
rectangle('position',[out.regions{3}(i,1),out.regions{3}(j,1), ...
     (out.regions{3}(i,2)-out.regions{3}(i,1)),...
     (out.regions{3}(j,2)-out.regions{3}(j,1))])
  % Rectangle created from the fourth regions
rectangle('position',[out.regions{4}(i,1),out.regions{4}(j,1), ...
     (out.regions{4}(i,2)-out.regions{4}(i,1)),...
     (out.regions{4}(j,2)-out.regions{4}(j,1))])
 

  colormap(jet_inverted)

x1 = out.clusters{1}.pts(:,i);
y1 = out.clusters{1}.pts(:,j);
c1 = out.clusters{1}.vals(:)
scatter(x1,y1,[],c1)

% 
% x2 = out.clusters{1}.pts(:,i);
% y2 = out.clusters{1}.pts(:,j);
% c2 = out.clusters{1}.vals(:)
% scatter(x2,y2,[],c2)

% x3 = out.clusters{1}.pts(:,i);
% y3 = out.clusters{1}.pts(:,j);
% c3 = out.clusters{1}.vals(:)
% scatter(x3,y3,[],c3)
% 
% x4 = out.clusters{1}.pts(:,i);
% y4 = out.clusters{1}.pts(:,j);
% c4 = out.clusters{1}.vals(:)
% scatter(x4,y4,[],c4)


colorbar('')

 hold off
