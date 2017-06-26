%% Interactive graph 

% Author : Noëlle FAVIER
% 
% Client : Santosh Arvind ADIMOOLAM

% Script to test all the functions

%% Clean Matlab

clear all
close all
clc 



% load new_data
addpath(genpath('1_data'))
load donnees_nono


global DATA

% plot_rectangles(DATA.Exp1, 2, 8)


% interactive_graph(DATA.Exp1, 1, 2, 1)


GUI_interactive_graph


% GUI_interactive_graph_all_samples(Out_exp1.all_samples,1)


% interactive_graph_all_samples(DATA.Exp1.all_samples, 1, 2, 1)


% plot_rectangles_and_colore_selected_one(DATA.Exp3, 1, 5, 5)

