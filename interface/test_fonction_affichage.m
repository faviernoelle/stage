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



global TAB_DIM
TAB_DIM = zeros(10,3) ;
TAB_DIM(:,3) = 40 ; 
TAB_DIM(:,1) = 1:10 ;

TAB_DIM(1,2)= 20 ;
TAB_DIM(1,3)= 30 ;

load all_exp
% load cl0

global DATA
% DATA =struct('exp', Out) ; 

DATA = data ;

% interactive_graph(DATA.Exp1, 1, 2, 1)

GUI_interactive_graph

% figure()
% plot_rectangles(DATA.Exp3, 1, 5, 5)

% plot_signal(DATA.Exp2, 1, 2, 1)

% coverage = compute_global_coverage(DATA.Exp1) ;

% region = get_min_rob(DATA.Exp1) 

% figure()
% plot_new_rectangles(DATA.Exp3, 1, 5, 5, TAB_DIM)

