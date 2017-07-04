%% Interactive graph 

% Author : Noëlle FAVIER

% Client : Santosh Arvind ADIMOOLAM

% Script to test all the functions

%% Clean Matlab

clear all
close all
clc 

%% Test of the functions

addPath

% load data_a_tester
% load data_test
load all_exp


global DATA
DATA = data ;



% interactive_graph(DATA.Exp1, 1, 2, 1)


GUI_interactive_graph


% plot_rectangles_and_colore_selected_one(DATA.Exp3, 1, 5, 5)


% plot_signal(DATA.Exp2, 1, 2, 1)


% coverage = compute_global_coverage(DATA.Exp1) ;


% region = get_min_rob(DATA.Exp1) 
