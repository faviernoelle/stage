%% Interactive graph 

% Author : Noëlle FAVIER

% Client : Toyota

% Script to test all the functions

%% Clean Matlab

clear all
close all
clc 

%% Test of the functions

addPath

load parametre

global DATA

% load Experience1
% DATA = struct('exp',Out_exp1) ;
% load Experience2
% DATA = struct('exp',Out_exp2) ;
% load Experience3
% DATA = struct('exp',Out_exp3) ;
% load Experience4
% DATA = struct('exp',Out_exp4) ;
load exp_compl
DATA = struct('exp', Out) ;
% load cl0

global PARAM 
% global COVERAGE 

% PARAM.tab_dim(1,3) = 20 ;
PARAM.Nb_point = 10 ;
PARAM.Grid_discretisation = zeros(10,1) + 4 ;

% interactive_graph(DATA.Exp1, 1, 2, 1)
GUI_interactive_graph

% figure()
% plot_rectangles(DATA.exp, 1, 2, 2)

% plot_signal(DATA.Exp1, 1, 2, 1, PARAM)

% coverage = compute_global_coverage(DATA.Exp1, PARAM) ;

% [rank, line, value] = get_min_rob(DATA.Exp3) 

% figure()
% plot_new_rectangles(DATA.Exp3, 1, 5, 5, PARAM)

% plot_robustness(DATA.Exp3, 1, 5, 5, PARAM)

%  [rank, regions, line, value] = sort_robustness(DATA.exp) ;

% new_data = sort_table(data,column)