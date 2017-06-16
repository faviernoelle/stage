function interactive_graph(Out, i, j, rectangle, varargin)
% interactive_graph(Out, i, j, varargin)
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



global colone1 colone2 values column

colone1 = i ;
colone2 = j ;
values = Out
column = rectangle

H = figure();



% plot points in the figure


% Définition of color used to plot
colormap(jet_inverted)

% selection of the points
x = Out.clusters{column}.pts(:,i);
y = Out.clusters{column}.pts(:,j);
% Selection of the data for the range of the color
c = Out.clusters{column}.vals(:)

% plot
scatter(x,y,[],c)

% add color bar
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

% function which act when the mouse is being moved (get the current 
% position of the mouse)
CurrentPoint = get(gca,'CurrentPoint');
% load the current position of the mouse in global variables
global pointeurX pointeurY
pointeurX=CurrentPoint(1,1);
pointeurY=CurrentPoint(2,2);


function MouseClick(~,~)

% function which act when we click with the mouse :
% When we do a left click in every case disp (left click) and
    % if it's on a point -> plot robustness value
    % if it's not on a point -> do nothing
    
    
global pointeurX pointeurY colone1 colone2 values column

% Left click
if strcmpi(get(gcf,'SelectionType'), 'Normal')
    disp('left click')

% set value epsilon such that if the mouse is to far away from the point do
% nothin
    epsilon = 0.3 ;
    % for every point test the distance between the value X of the point
    % and the value X of the mouse and the same for Y and if both values
    % are smaller than epsilon write on the graph the robustness value of
    % the point
    for l=1:50 
        % test the difference between position of the point and position of
        % the mouse
        if abs(pointeurY - values.clusters{column}.pts(l,colone2))< epsilon & ...
                abs(pointeurX - values.clusters{column}.pts(l,colone1))< epsilon
            
%             disp robustness value
            disp('robustness value of selected point :')
            values.clusters{column}.vals(l)
            
            % Write robustness value on the graph, the first two values are
            % used to define the position where you want to plot write the
            % text
            text(values.clusters{column}.pts(l,colone1),...
                values.clusters{column}.pts(l,colone2), ...
            num2str(values.clusters{column}.vals(l)))
            text(values.clusters{column}.pts(l,colone1)-1,...
                values.clusters{column}.pts(l,colone2)-1, ...
            [num2str(values.clusters{column}.pts(l,colone1)); num2str(values.clusters{column}.pts(l,colone2))])
        
        else
            % Do nothing
        end
    end
    
% Right click
elseif strcmpi(get(gcf,'SelectionType'), 'Alt')
    disp('right click')
end


function MouseScroll(~,Event)
% Not used for now
disp('use of mouse scroll')

function KeyPress(~,Event)
% Not used for now
disp('a key has been pressed')






