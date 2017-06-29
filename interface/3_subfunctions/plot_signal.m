function plot_signal(Out, i, j, rectangle, varargin)

% plot_signal(out,i,j,col)
% When rigth click on a point plot the signal corresponding to that point
% When  left click on a place where there is no point, create and plot a
% new signal
% out = data to plot. Must be in a structure named DATA and the elements in
% DATA must be statFalsify structures
% i = values of dimension projection used on x
% j = values of dimension projection used on y
% rectangle = rectangle selected. The points in this rectangle will be 
% filled and the edge of this rectangle will be coloured

global COLONE1 COLONE2 VALUES COLUMN

COLONE1 = i ;
COLONE2 = j ;
VALUES = Out ;
COLUMN = rectangle ;

H = figure() ;

% Définition of color used to plot
colormap(jet_inverted)

% selection of the points
x = Out.clusters{COLUMN}.pts(:,COLONE1);
y = Out.clusters{COLUMN}.pts(:,COLONE2);
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
    
global POINTEUR_X POINTEUR_Y COLONE1 COLONE2 VALUES COLUMN CONSIGNE X_PLOT

% Left click
if strcmpi(get(gcf,'SelectionType'), 'Normal')
    PARAM.epsilon = 0.5 ;
    
    actual_fewest_dist = 1 ; 
    
    line = 0 ;
    
    
    % for every point test the distance between the value X of the point
    % and the value X of the mouse and the same for Y and if both values
    % are smaller than epsilon call the interface GUI_plot_signal that plot
    % the signal (to get more detail tape 'help_GUI_plot_signal'
    for l=1:length(VALUES.clusters{COLUMN}.pts)
        % test the difference between position of the point and position of
        % the mouse
        % Define a cercle of radius epsilon arround the point such that if 
        % the mouse is in this cercle the GUI is called otherwise nothing
        % is done
        
        dist = (POINTEUR_Y - VALUES.clusters{COLUMN}.pts(l,COLONE2)) * ...
               (POINTEUR_Y - VALUES.clusters{COLUMN}.pts(l,COLONE2)) + ...
               (POINTEUR_X - VALUES.clusters{COLUMN}.pts(l,COLONE1)) * ...
               (POINTEUR_X - VALUES.clusters{COLUMN}.pts(l,COLONE1)) ;
        
        % Load the lowest value of distance to get exactly the good point
        % (this means that if two points are near select only the nearest 
        % point of the mouse) 
        if sqrt(dist) < PARAM.epsilon
            if dist < actual_fewest_dist
                actual_fewest_dist = dist ; 
                line = l ; 
            end 
        else 
            %do nothing
        end
    end
    
        if line ~= 0
             u_x = VALUES.clusters{COLUMN}.pts(line,:) ; % get the value to plot
             
             
             % axis x will be values from 1 to dimension number + 1
             X_PLOT = 0:numel(u_x) ; 
             
             %necessary to plot a constant piecewise function
              CONSIGNE = [u_x u_x(end)] ; 
             
             % call the function to plot the signal and its robustness 
             % value and to be able to test this signal in simulation 
             GUI_plot_signal
        else 
            % Do nothing
        end

          

% Right clik
elseif strcmpi(get(gcf,'SelectionType'), 'Alt')
    PARAM.epsilon = 0.5 ;
    
    tracer = 1 ; 
    
    % for every point test the distance between the value X of the point
    % and the value X of the mouse and the same for Y and if both values
    % are smaller than epsilon it means that the click was on a point so
    % nothing is done otherwise call the function to plot the new signal
    for l=1:length(VALUES.clusters{COLUMN}.pts)
        
        
        % test the difference between position of the point and position of
        % the mouse
        % Define a cercle of radius epsilon arround the point such that if the 
        % mouse is in this cercle the values of the point are written 
        % otherwise  they are not written
        dist = (POINTEUR_Y - VALUES.clusters{COLUMN}.pts(l,COLONE2)) * ...
               (POINTEUR_Y - VALUES.clusters{COLUMN}.pts(l,COLONE2)) + ...
               (POINTEUR_X - VALUES.clusters{COLUMN}.pts(l,COLONE1)) * ...
               (POINTEUR_X - VALUES.clusters{COLUMN}.pts(l,COLONE1)) ;

        if sqrt(dist) < PARAM.epsilon
            % If the distance between the point where the mouse was during
            % the click is smaller than epsilon it means that the mouse was
            % on a point so tracer becomes 0 and the plot will not happens
            tracer = 0 ;   

        else
            % Don nothing                      
        end    
    end
    
    
    if tracer == 1        
        
        % Create new points randomly
        CONSIGNE = round(rand(1,numel(VALUES.clusters{COLUMN}.pts(l,:))+1)*40) ;
        
        % axis x will be values from 1 to dimension + 1
        X_PLOT = 0:numel(VALUES.clusters{COLUMN}.pts(l,:)) ;         
        % The position of the mouse will determine two points in the graph
        % for the two dimensions selected
        for i=1:numel(VALUES.clusters{COLUMN}.pts(l,:))
            CONSIGNE(:,COLONE1) = POINTEUR_X ;
            CONSIGNE(:,COLONE2) = POINTEUR_Y ;
        end

        % call the function to plot the signal and its robustness 
        % value and to be able to test this signal in simulation 
        GUI_plot_signal
                
     end
    
    
end

function MouseScroll(~,Event)
% Not used for now
disp('use of mouse scroll')

function KeyPress(~,Event)
% Not used for now
disp('a key has been pressed')


