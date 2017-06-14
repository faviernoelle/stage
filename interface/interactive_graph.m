function interactive_graph(i, j, varargin)

if nargin == 0
  clear all
end

close all
clc

fprintf(['--------------------\n', ...
  'B-spline Lab\nPress ''H'' for help.\n', ...
  '--------------------\n\n'])

load Experience1

global Out_exp1 i j 

% i = 1 ;
% j = 2 ;

H = figure();
map = [0.9, 0, 0
       0.87, 0.42, 0.078
        0.145, 0.99, 0.91
       0, 0, 0.9]
    
colormap(map)
x = Out_exp1.clusters{1, 1}.pts(:,i);
y = Out_exp1.clusters{1, 1}.pts(:,j);
c = Out_exp1.clusters{1, 1}.vals(:)
scatter(x,y,[],c)
     
            
set(H, 'MenuBar','none');
set(H,'ToolBar','none');
set(H, 'Renderer','OpenGL');
hold on

set(H,'WindowButtonMotionFcn',@MouseMove);
set(H,'WindowButtonDownFcn',@MouseClick);
set(H,'WindowScrollWheelFcn',@MouseScroll);
set(H,'KeyPressFcn',@KeyPress ); 

%  axis([0 10 0 40])
 
 global pointeurX pointeurY
            
disp('fenetre ouverte')

function MouseMove(~,~)

global pointeurX pointeurY
CurrentPoint = get(gca,'CurrentPoint');
% CurrentPoint
pointeurX=CurrentPoint(1,1);
pointeurY=CurrentPoint(2,2);

% disp('valeur actuelle du pointeur :', num2str(CurrentPoint))

function MouseClick(~,~, i, j)

global pointeurX pointeurY Out_exp1 i j 
if strcmpi(get(gcf,'SelectionType'), 'Normal')
    disp('left click')

% Left click
    epsilon = 0.3 ;
    for l=1:50 
        if abs(pointeurY - Out_exp1.clusters{1, 1}.pts(l,j))< epsilon & ...
                abs(pointeurX - Out_exp1.clusters{1, 1}.pts(l,i))< epsilon 
            disp('robustness value of selected point :')
            Out_exp1.clusters{1, 1}.vals(l)
            text(Out_exp1.clusters{1, 1}.pts(l,i),Out_exp1.clusters{1, 1}.pts(l,j), ...
            num2str(Out_exp1.clusters{1, 1}.vals(l)))
        else              
        end
    end
    
% Right click
elseif strcmpi(get(gcf,'SelectionType'), 'Alt')
    disp('right click')
end


function MouseScroll(~,Event)
disp('use of mouse scroll')

function KeyPress(~,Event)
disp('a key has been pressed')






