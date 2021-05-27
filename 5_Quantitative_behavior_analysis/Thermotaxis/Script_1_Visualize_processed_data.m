%% Thermotaxis behavioral analysis used in Hernandez-Nunez et al 2021 Science Advances
% Script 1: Load processed data and visulize results
% Author: Luis Hernandez Nunez
% Questions: luishernandeznunez@fas.harvard.edu
clear all; close all; clc;
%%

cd('C:\Users\Luis\Dropbox\Samuel_Lab\9_Manuscripts\2_Mechanistic_thermotaxis_paper\Github_Materials\5_Quantitative_behavior_analysis\Thermotaxis') % Directory with the data


% Below the homeostatic set-point

load('Fast_BelowHSP_w1118.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'g')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of w1118 larvae below HSP')

load('Fast_BelowHSP_Ir68aPB.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'r')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir68aPB larvae below HSP')

load('Fast_BelowHSP_Ir21a123.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'b')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir21a123 larvae below HSP')


load('Fast_BelowHSP_Ir93aMI.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'k')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir93aMI larvae below HSP')


%Near the homeostatic set-point

load('Fast_NearHSP_w1118.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'g')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of w1118 larvae near HSP')

load('Fast_NearHSP_Ir68aPB.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'r')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir68aPB larvae near HSP')

load('Fast_NearHSP_Ir21a123.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'b')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir21a123 larvae near HSP')


load('Fast_NearHSP_Ir93aMI.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'k')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir93aMI larvae near HSP')

% above the homeostatic set-point

load('Fast_AboveHSP_w1118.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'g')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of w1118 larvae above HSP')

load('Fast_AboveHSP_Ir68aPB.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'r')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir68aPB larvae above HSP')

load('Fast_AboveHSP_Ir21a123.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'b')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir21a123 larvae above HSP')


load('Fast_AboveHSP_Ir93aMI.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'k')
axis([0 48 0 0.4])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir93aMI larvae above HSP')


% Slow signal around the homeostatic set-point

load('Slow_NearHSP_w1118.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'g')
axis([0 120 0 0.2])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of w1118 larvae around HSP')

load('Slow_NearHSP_Ir68aPB.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'r')
axis([0 120 0 0.2])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir68aPB larvae around HSP')

load('Slow_NearHSP_Ir21a123.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'b')
axis([0 120 0 0.2])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir21a123 larvae around HSP')


load('Slow_NearHSP_Ir93aMI.mat','binned_P_R_to_T_gR','binned_SEM_R_to_T_gR','time_points')
figure()
shadedErrorBar(time_points, binned_P_R_to_T_gR,binned_SEM_R_to_T_gR,'k')
axis([0 120 0 0.2])
xlabel('time(s)')
ylabel('Turn rate (Hz)')
title('Thermotactic turn rate response of Ir93aMI larvae around HSP')


