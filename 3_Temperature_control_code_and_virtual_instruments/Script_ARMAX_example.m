%% ARMAX systems identification used in Hernandez-Nunez et al 2021 Science Advances
% Script 1: Example on how to fit ARMAX model for temperature data input-output
% Author: Luis Hernandez Nunez
% Questions: luishernandeznunez@fas.harvard.edu
clear all; close all; clc;
%% Load temperature data
Temp_input  = load('Sine_phase_15_input.mat'); 
Temp_output = load('Sine_phase_15_output.mat');
%% Format data as a iddata element 
%Use the same sampling time specified in LabVIEW
data = iddata( T_output , T_input , 0.2 ); 
%% Estimate ARMAX model 
%Fit the temperature control transfer function
na = 2;
nb = 1;
nc = 2;
nk = 1;
sys = armax(data,[na nb nc nk]);
%% 
compare(data,sys)