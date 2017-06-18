function interactive_graph_all_samples(Out, i, j, rectangle, varargin)
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



global colone1 colone2 values

colone1 = i ;
colone2 = j ;
values = Out
% column = rectangle

H = figure();



% plot points in the figure


% Définition of color used to plot
colormap(jet_inverted)

% selection of the points
x = Out.pts(:,i);
y = Out.pts(:,j);
% Selection of the data for the range of the color
c = Out.vals(:)

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
    for l=1:length(values.pts)
        % test the difference between position of the point and position of
        % the mouse
        val_a_tester_Y = values.pts(l,colone2) ;
        val_a_tester_X = values.pts(l,colone1) ;
        if abs(pointeurY - val_a_tester_Y )< epsilon & ...
                abs(pointeurX - val_a_tester_X)< epsilon
            
%             disp robustness value
            disp('robustness value of selected point :')
            values.vals(l)
            
            % Write robustness value on the graph, the first two values are
            % used to define the position where you want to write the
            % text and the next one is the value you want to plot on the
            % graph
            text(values.pts(l,colone1),...
                values.pts(l,colone2), ...
            num2str(values.vals(l)))
%         pos_aff_x = values.pts(l,colone1)-1 ;
%         pos_aff_y = values.pts(l,colone2)-1 ;
           text(double(values.pts(l,colone1)-3),...
                double(values.pts(l,colone2)-3), ...
            ['x = ' num2str(values.pts(l,colone1)); 'y = ' num2str(values.pts(l,colone2))])
%         
        disp(num2str(values.pts(l,colone1)))
        disp(num2str(values.pts(l,colone2)))

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






