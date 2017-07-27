function plot_signal(Out, i, j, rectangle, PARAM, varargin)

% plot_signal(out,i,j,rectangle, varargin)
% When rigth click on a point plot the signal corresponding to that point
% When  left click on a place where there is no point, create and plot a
% new signal
% out = data to plot. Must be in a structure named DATA and the elements in
% DATA must be statFalsify structures
% i = values of dimension projection used on x
% j = values of dimension projection used on y
% rectangle = rectangle selected. 
% Out.clusters{rectangles}.pts(:,i) gives us x on the graph
% Out.clusters{rectangles}.pts(:,j) gives us y on the graph

global COLONE1 COLONE2 VALUES COLUMN

COLONE1 = i ;
COLONE2 = j ;
VALUES = Out ;
COLUMN = rectangle ;

H = figure() ;

% Définition of color used to plot
colormap(jet_inverted)


% selection of the points
pt = 1 ;

limite_x = [PARAM.tab_dim(i,2) PARAM.tab_dim(i,3)] ;
limite_y = [PARAM.tab_dim(j,2) PARAM.tab_dim(j,3)] ;



for h=1:numel(Out.clusters{COLUMN}.pts(:,1))
       if Out.clusters{COLUMN}.pts(h,i) < limite_x(2) && ...
            Out.clusters{COLUMN}.pts(h,i) > limite_x(1) && ...
            Out.clusters{COLUMN}.pts(h,j) < limite_y(2) && ...
            Out.clusters{COLUMN}.pts(h,j) > limite_y(1)
        
        x(pt) = Out.clusters{COLUMN}.pts(h,i);
        y(pt) = Out.clusters{COLUMN}.pts(h,j);
        % Selection of the data for the range of the color
        c(pt) = Out.clusters{COLUMN}.vals(h) ;
        pt = pt + 1 ;
    end
end


% plot
scatter(x,y,[],c)
xlabel(['Projection dimension ', num2str(COLONE1)])
ylabel(['Projection dimension ', num2str(COLONE2)])

bounds_x = [Out.regions{COLUMN}(COLONE1,1) Out.regions{COLUMN}(COLONE1,2)] ;
bounds_y = [Out.regions{COLUMN}(COLONE2,1) Out.regions{COLUMN}(COLONE2,2)] ;


axis([bounds_x bounds_y])

title(['Points in rectangle ' num2str(COLUMN) ' for x = ' num2str(i) ', y = ' num2str(j) ])

% add color bar
colorbar('')


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
% When the user do a left click
    % if it's on a point -> open plot signal
    % if it's not on a point -> do nothing
% When the user do a right click
    % if it's on a point -> do nothing
    % if it's not on a point -> create and plot a new signal with values
    % near the values of the signal with the lowest robustness except for
    % the dimension i and j the values of the signal are the values of the
    % position of the mouse
    
    
% global variable to determine if the plot will be a new signal or an 
% existing signal = becomes 1 if the click was a left click on a point,
% becomes 0 if the point was a rigth click not on a point
% global POINT_SELECTED
    
% global variables to get the current position of the mouse
global POINTEUR_X POINTEUR_Y 

% global variables to know the parameters of the data 
global COLONE1 COLONE2 VALUES COLUMN 

% global variables that will be plot in the GUI_plot_signal
global CONSIGNE X_PLOT

global PARAM

% Left click
if strcmpi(get(gcf,'SelectionType'), 'Normal')
    [PARAM(:).epsilon] = 0.5 ;
    
    % 
    actual_fewest_dist = 1 ; 
    
    
    % global variable to test if a point has been found and to get the line
    % to plot the signal corresponding to the point
    global LINE VALEURS
    
    
    
    LINE = 0 ;
%     POINT_SELECTED = 0 ;
    
    
    % for every point compute the addition of the square of the distance 
    % between the value X of the point and the value X of the mouse and the 
    % same for Y and if both values are smaller than epsilon call the 
    % interface GUI_plot_signal that plot the signal
    for l=1:numel(VALUES.clusters{COLUMN}.pts(:,1))
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
        % (this means that if two points are near thanks to these line only
        % the nearest point to the mouse will be selected) 
        % Load also the value of the line to be able to plot the signal
        % corresponding to the value
        
        % Test to determine if the click was on a point
        if sqrt(dist) < PARAM.epsilon
            
            
            % if the click was on a point, test to determine which point is
            % the nearest to the position of the mouse when the click happened 
            if dist < actual_fewest_dist
                actual_fewest_dist = dist ; 
                LINE = l ;
%                 POINT_SELECTED = 1 ;
            end 
        else 
            %do nothing
        end
    end
    
        if LINE ~= 0
             u_x = VALUES.clusters{COLUMN}.pts(LINE,:) ; % get the value to plot
             
             
             % axis x will be values from 0 to dimension number
             X_PLOT = 1:PARAM.Nb_point+1 ; 
             
             % signal to plot = values of the signal and last value of this
             % signal to have a signal complete from 1 to N+1  
             CONSIGNE = [u_x u_x(end)] ; 
             
             VALEURS = VALUES ;
             
             % call the function to plot the signal and its robustness 
             % value and to be able to test this signal in simulation 
             GUI_plot_signal
        
        else 
            % Do nothing
        end

        
% Right clik
elseif strcmpi(get(gcf,'SelectionType'), 'Alt') 
    
    [PARAM(:).epsilon] = 0.5 ;
    
    
    % variable used to test if the click was on a point or not so to know
    % if a signal will be plot or not (tracer = plot in french)
    tracer = 1 ; 
    
    % for every point test the distance between the value X of the point
    % and the value X of the mouse and the same for Y and if both values
    % are smaller than epsilon it means that the click was on a point so
    % nothing is done otherwise call the function to plot the new signal
    for l=1:numel(VALUES.clusters{COLUMN}.pts(:,1))
        
        
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
            % on a point so 'tracer' becomes 0 and the plot will not happens
            tracer = 0 ;   

        else
            % Do nothing                      
        end    
    end
    
    
    if tracer == 1        
        % Create new points randomly
        % CONSIGNE = round(rand(1,numel(VALUES.clusters{COLUMN}.pts(l,:))+1)*40) ;
        

%         % Create new points near the points of the signal with the lowest
%         % robustness value
%         [region, line, ~] = get_min_rob(VALUES) ;
%         
%         % Selectionne the signal with the lowest robustesse of all signals 
%         % and modify it a ligttle 
%         signal = VALUES.clusters{region}.pts(line,:) ; 
%         signal_mod = signal + 0.01 * signal ; % To be improved 

        global phi
        
        cbs_reinit 
        
        global CBS start
        
        
        start = 1 ;
        
%         rng(r,'twister');
        
        w_rob = 0.5 ;
        init_sim = 10 ;
        max_sim = 10 ;
        time_lim = 60 ;
        Out = [] ;
        
        Out = StatFalsify(Out, CBS, phi, w_rob, init_sim, max_sim, time_lim) ;

        % signal to plot = values of the signal and last value of this
        % signal to have a signal complete from 1 to N+1 
%         CONSIGNE = [signal_mod signal_mod(end)] ; 


        [region, line, ~] = get_min_rob(Out) ;
        signal = Out.clusters{region}.pts(line,:) ;
        
        CONSIGNE = [signal signal(end)] ;
        
        VALEURS = Out ;
        
        

        % axis x will be values from 1 to dimension + 1
        X_PLOT = 1:PARAM.Nb_point+1 ;         
        % The position of the mouse will determine two points in the graph
        % for the two dimensions selected
        
        
%         for i=1:numel(VALUES.clusters{COLUMN}.pts(l,:))
%             CONSIGNE(:,COLONE1) = POINTEUR_X ;
%             CONSIGNE(:,COLONE2) = POINTEUR_Y ;
%         end

        
%         POINT_SELECTED = 0 ;
        
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


