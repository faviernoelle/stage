%% Interactive graph 

% Author : Noëlle FAVIER

% Client : Toyota

% Script to test all the functions

%% Clean Matlab

clear vars
close all
clc 

%% Test of the functions

addPath

load parametre

% load all_exp
load cl0

global DATA PARAM
DATA = struct('exp', Out) ; 

% DATA = data ;

% PARAM.tab_dim(1,3) = 20 ;
PARAM.Nb_point = 10 ;
PARAM.Grid_discretisation = zeros(10,1) + 4 ;

% interactive_graph(DATA.Exp1, 1, 2, 1)
GUI_interactive_graph

% figure()
% plot_rectangles(DATA.exp, 1, 2, 2)

% plot_signal(DATA.exp, 1, 2, 1, PARAM)

% coverage = compute_global_coverage(DATA.Exp1, PARAM) ;

% region = get_min_rob(DATA.Exp1) 

% figure()
% plot_new_rectangles(DATA.Exp3, 1, 5, 5, PARAM)

% plot_robustness(DATA.Exp3, 1, 5, 5, PARAM)