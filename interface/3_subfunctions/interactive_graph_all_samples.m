function interactive_graph_all_samples(Out, i, j, rectangle, varargin)
% interactive_graph(Out, i, j, varargin)
% 
% 
% 
% 


if nargin == 0
  clear all
end


global COLONE1 COLONE2 VALUES

COLONE1 = i ;
COLONE2 = j ;
VALUES = Out ;
% column = rectangle

H = figure();



% plot points in the figure


% Définition of color used to plot
colormap(jet_inverted)

% selection of the points
x = Out.pts(:,i);
y = Out.pts(:,j);
% Selection of the data for the range of the color
c = Out.vals(:) ;

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
global POINTEUR_X POINTEUR_Y
POINTEUR_X=CurrentPoint(1,1);
POINTEUR_Y=CurrentPoint(2,2);


function MouseClick(~,~)

% function which act when the click is used :
% When we do a left click in every case disp (left click) and
    % if it's on a point -> plot robustness value
    % if it's not on a point -> do nothing
% click gauche clear texts on the figure
    
    
global POINTEUR_X POINTEUR_Y COLONE1 COLONE2 VALUES column

% Left click
if strcmpi(get(gcf,'SelectionType'), 'Normal')

% set value epsilon such that if the mouse is to far away from the point do
% nothin
    PARAM.epsilon = 0.3 ;
    % for every point test the distance between the value X of the point
    % and the value X of the mouse and the same for Y and if both values
    % are smaller than epsilon write on the graph the robustness value of
    % the point
    for l=1:length(VALUES.pts)
        % test the difference between position of the point and position of
        % the mouse
        val_a_tester_Y = VALUES.pts(l,COLONE2) ;
        val_a_tester_X = VALUES.pts(l,COLONE1) ;
        if abs(POINTEUR_Y - val_a_tester_Y )< PARAM.epsilon & ...
                abs(POINTEUR_X - val_a_tester_X)< PARAM.epsilon
           
            
            % Part of the code to get the parameters to put the texts at the right position
%             min = values.regions{column}(colone2,1);
%             max = values.regions{column}(colone2,2);
            min = 0;
            max = 40 ;
            PARAM.affich_text_robu = 1.5/40 ; % parameter calculed to optimize visualization
            delta = (max-min)*(PARAM.affich_text_robu) ;
            
            
            % Write robustness value on the graph, the first two values are
            % used to define the position where you want to write the
            % text and the next one is the value you want to plot on the
            % graph
            text(VALUES.pts(l,COLONE1), VALUES.pts(l,COLONE2), ...
            num2str(VALUES.vals(l)))
           text(double(VALUES.pts(l,COLONE1)), double(VALUES.pts(l,COLONE2)-delta), ...
            ['x = ' num2str(VALUES.pts(l,COLONE1))])
           text(double(VALUES.pts(l,COLONE1)), double(VALUES.pts(l,COLONE2)-2 * delta), ...
            ['y = ' num2str(VALUES.pts(l,COLONE2))])


        else
            % Do nothing
        end
    end
    
% Right click
elseif strcmpi(get(gcf,'SelectionType'), 'Alt')
    allText = findobj(gca,'Type','Text') ;
    delete(allText)
end


function MouseScroll(~,Event)
% Not used for now
disp('use of mouse scroll')

function KeyPress(~,Event)
% Not used for now
disp('a key has been pressed')






