%% Optogenetics behavioral analysis used in Hernandez-Nunez et al 2021 Science Advances
% Script 1: Load processed data and visulize results
% Author: Luis Hernandez Nunez
% Questions: luishernandeznunez@fas.harvard.edu
clear all; close all; clc;
%% Visualize data of Fig.6
cd('C:\Users\Luis\Dropbox\Samuel_Lab\9_Manuscripts\2_Mechanistic_thermotaxis_paper\Github_Materials\5_Quantitative_behavior_analysis\Optogenetics')
load('CCs_Optogenetics_BlowHSP.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
set(gcf,'Color','white')
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'c')
axis([0 120 0 0.65])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Optogenetic control of CCs turn rate response below HSP')

cd('C:\Users\Luis\Dropbox\Samuel_Lab\9_Manuscripts\2_Mechanistic_thermotaxis_paper\Github_Materials\5_Quantitative_behavior_analysis\Optogenetics')
load('CCs_Optogenetics_NearHSP.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
set(gcf,'Color','white')
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'c')
axis([0 120 0 0.65])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Optogenetic control of CCs turn rate response near HSP')

cd('C:\Users\Luis\Dropbox\Samuel_Lab\9_Manuscripts\2_Mechanistic_thermotaxis_paper\Github_Materials\5_Quantitative_behavior_analysis\Optogenetics')
load('CCs_Optogenetics_AboveHSP.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
set(gcf,'Color','white')
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'c')
axis([0 120 0 0.65])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Optogenetic control of CCs turn rate response above HSP')

cd('C:\Users\Luis\Dropbox\Samuel_Lab\9_Manuscripts\2_Mechanistic_thermotaxis_paper\Github_Materials\5_Quantitative_behavior_analysis\Optogenetics')
load('WCs_Optogenetics_BlowHSP.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
set(gcf,'Color','white')
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'r')
axis([0 120 0 0.12])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Optogenetic control of WCs turn rate response below HSP')

cd('C:\Users\Luis\Dropbox\Samuel_Lab\9_Manuscripts\2_Mechanistic_thermotaxis_paper\Github_Materials\5_Quantitative_behavior_analysis\Optogenetics')
load('WCs_Optogenetics_NearHSP.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
set(gcf,'Color','white')
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'r')
axis([0 120 0 0.12])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Optogenetic control of WCs turn rate response near HSP')


cd('C:\Users\Luis\Dropbox\Samuel_Lab\9_Manuscripts\2_Mechanistic_thermotaxis_paper\Github_Materials\5_Quantitative_behavior_analysis\Optogenetics')
load('WCs_Optogenetics_AboveHSP.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
set(gcf,'Color','white')
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'r')
axis([0 120 0 0.12])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Optogenetic control of WCs turn rate response above HSP')


