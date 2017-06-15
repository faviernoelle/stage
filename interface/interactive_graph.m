function interactive_graph(Out, i, j, varargin)
%
% 
% 
% 
% 


if nargin == 0
  clear all
end

clc

% fprintf(['--------------------\n', ...
%   'B-spline Lab\nPress ''H'' for help.\n', ...
%   '--------------------\n\n'])



global colone1 colone2 values

colone1 = i ;
colone2 = j ;
values = Out

H = figure();



% plot points in the figure


% Définition of color used to plot
colormap(jet_inverted)

% selection of the points
x = Out.clusters{1}.pts(:,i);
y = Out.clusters{1}.pts(:,j);
% Selection of the data for the range of the color
c = Out.clusters{1}.vals(:)
% plot
scatter(x,y,[],c)
colorbar('')
            
% set option of graphic 
set(H, 'MenuBar','none');
set(H,'ToolBar','none');
set(H, 'Renderer','OpenGL');
hold on

% set option of graphic to be able to use the mouse
set(H,'WindowButtonMotionFcn',@MouseMove);
set(H,'WindowButtonDownFcn',@MouseClick);
set(H,'WindowScrollWheelFcn',@MouseScroll);
set(H,'KeyPressFcn',@KeyPress ); 

disp('fenetre ouverte')

function MouseMove(~,~)

% function which act when we move the mouse (get the current position of
% the mouse)
global pointeurX pointeurY
CurrentPoint = get(gca,'CurrentPoint');
% CurrentPoint
pointeurX=CurrentPoint(1,1);
pointeurY=CurrentPoint(2,2);

% disp('valeur actuelle du pointeur :', num2str(CurrentPoint))

function MouseClick(~,~)

% function which act when we click with the mouse :
% in every case disp (left click) and
    % if it's on a point -> plot robustness value
    % if it's not on a point -> do nothing
    
    
global pointeurX pointeurY colone1 colone2 values

% Left click
if strcmpi(get(gcf,'SelectionType'), 'Normal')
    disp('left click')


    epsilon = 0.3 ;
    for l=1:50 
        if abs(pointeurY - values.clusters{1, 1}.pts(l,colone2))< epsilon & ...
                abs(pointeurX - values.clusters{1, 1}.pts(l,colone1))< epsilon 
            disp('robustness value of selected point :')
            values.clusters{1, 1}.vals(l)
            text(values.clusters{1, 1}.pts(l,colone1),values.clusters{1, 1}.pts(l,colone2), ...
            num2str(values.clusters{1, 1}.vals(l)))
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






