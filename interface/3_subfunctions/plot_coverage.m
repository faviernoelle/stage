function plot_coverage(Out, i, j, rectangle, varargin)

% plot_rectangles_and_colore_selected_one(out,i,j,col)
% out = data to plot. Must be in a structure named DATA and the elements in
% DATA must be statFalsify structures
% i = values of dimension projection used on x
% j = values of dimension projection used on y
% col = rectangle selected. The points in this rectangle will be filled and
% the edge of this rectangle will be coloured

global COLONE1 COLONE2 VALUES COLUMN

COLONE1 = i ;
COLONE2 = j ;
VALUES = Out ;
COLUMN = rectangle ;

H = figure() ;

% Définition of color used to plot
colormap(jet_inverted)

% selection of the points
x = Out.clusters{COLUMN}.pts(:,i);
y = Out.clusters{COLUMN}.pts(:,j);
% Selection of the data for the range of the color
c = Out.clusters{COLUMN}.vals(:) ;

% plot
scatter(x,y,[],c)
xlabel(['Projection dimension ', num2str(COLONE1)])
ylabel(['Projection dimension ', num2str(COLONE2)])

title(['Points in rectangle ' num2str(COLUMN) ' for x = ' num2str(i) ', y = ' num2str(j) ])

% add color bar
colorbar('')


hold on

% set dimension of the graphic
% set(H, 'Position', [10 50 1350 687]);

% set option of graphic to be able to use the mouse
set(H,'WindowButtonMotionFcn',@MouseMove);
set(H,'WindowButtonDownFcn',@MouseClick);
set(H,'WindowScrollWheelFcn',@MouseScroll);
set(H,'KeyPressFcn',@KeyPress ); 

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
    
global POINTEUR_X POINTEUR_Y COLONE1 COLONE2 VALUES COLUMN

% Left click
if strcmpi(get(gcf,'SelectionType'), 'Normal')
    PARAM.epsilon = 0.1 ;
    % for every point test the distance between the value X of the point
    % and the value X of the mouse and the same for Y and if both values
    % are smaller than epsilon write on the graph the robustness value of
    % the point
    for l=1:length(VALUES.clusters{COLUMN}.pts)
        % test the difference between position of the point and position of
        % the mouse
        % Define a cercle of radius 0.1 arround the point such that if the 
        % mouse is in this cercle the values of the point are written 
        % otherwise  they are not written
        if sqrt((POINTEUR_Y - VALUES.clusters{COLUMN}.pts(l,COLONE2))  * ...
                (POINTEUR_Y - VALUES.clusters{COLUMN}.pts(l,COLONE2)) + ...
                (POINTEUR_X - VALUES.clusters{COLUMN}.pts(l,COLONE1))  * ...
                (POINTEUR_X - VALUES.clusters{COLUMN}.pts(l,COLONE1))) < PARAM.epsilon
            disp('plot signal')
        else 
            %do nothing
        end
    end

elseif strcmpi(get(gcf,'SelectionType'), 'Alt')
    PARAM.epsilon = 0.1 ;
    % for every point test the distance between the value X of the point
    % and the value X of the mouse and the same for Y and if both values
    % are smaller than epsilon write on the graph the robustness value of
    % the point
    for l=1:length(VALUES.clusters{COLUMN}.pts)
        % test the difference between position of the point and position of
        % the mouse
        % Define a cercle of radius 0.1 arround the point such that if the 
        % mouse is in this cercle the values of the point are written 
        % otherwise  they are not written
        if sqrt((POINTEUR_Y - VALUES.clusters{COLUMN}.pts(l,COLONE2))  * ...
                (POINTEUR_Y - VALUES.clusters{COLUMN}.pts(l,COLONE2)) + ...
                (POINTEUR_X - VALUES.clusters{COLUMN}.pts(l,COLONE1))  * ...
                (POINTEUR_X - VALUES.clusters{COLUMN}.pts(l,COLONE1))) > PARAM.epsilon
            if l == 1 
                disp('plot new signal')
            end
        else
            % Don nothing
        end

    
    end
end

function MouseScroll(~,Event)
% Not used for now
disp('use of mouse scroll')

function KeyPress(~,Event)
% Not used for now
disp('a key has been pressed')


