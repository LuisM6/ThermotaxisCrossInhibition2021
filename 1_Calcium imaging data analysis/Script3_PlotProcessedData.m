%% Calcium imaging analysis used in Hernandez-Nunez et al 2021 Science Advances
% Script 3: Load processed data and visulize results
% Author: Luis Hernandez Nunez
% Questions: luishernandeznunez@fas.harvard.edu
clear all; close all; clc;
%%
cd('C:\Users\Luis\Dropbox\Samuel_Lab\9_Manuscripts\2_Mechanistic_thermotaxis_paper\Github_Materials\1_Calcium imaging data analysis')
%% Figure 1 dataset
load('Slow_BelowHSP_WC.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.4 0.4])
title('WC responses to slow sine wave below set-point')

load('Slow_BelowHSP_WC_Ir68aPB.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.4 0.4])
title('WC Ir68a-/- responses to slow sine wave below set-point')

load('Slow_BelowHSP_WC_Ir93aMI.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.4 0.4])
title('WC Ir93a-/- responses to slow sine wave below set-point')

load('Slow_BelowHSP_WC_Ir25a2.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.4 0.4])
title('WC Ir25a-/- responses to slow sine wave below set-point')

load('Slow_BelowHSP_WC_Ir68_rescue.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.4 0.4])
title('WC Ir68a rescue responses to slow sine wave below set-point')

load('Slow_BelowHSP_WC_Ir93a_rescue.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.4 0.4])
title('WC Ir93a rescue responses to slow sine wave below set-point')

load('Slow_BelowHSP_WC_Ir25a_rescue.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.4 0.4])
title('WC Ir25a rescue responses to slow sine wave below set-point')

%% Figure 2 dataset
load('Slow_BelowHSP_WC.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.4 0.4])
title('WC responses to slow sine wave below set-point')

load('Slow_BelowHSP_WC_UAS_Ir21a.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.4 0.4])
title('WC->UAS-Ir21a responses to slow sine wave below set-point')

load('Slow_BelowHSP_CC_A.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'c')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.6 0.8])
title('CC-A responses to slow sine wave below set-point')

load('Slow_BelowHSP_CC_A_UAS_Ir68a.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'c')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.6 0.8])
title('CC-A->UAS-Ir68a responses to slow sine wave below set-point')

load('Slow_BelowHSP_CC_B.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'b')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.6 0.8])
title('CC-B responses to slow sine wave below set-point')

load('Slow_BelowHSP_CC_B_UAS_Ir68a.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'b')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.6 0.8])
title('CC-B->UAS-Ir68a responses to slow sine wave below set-point')


%% Figure 4 dataset
load('Fast_BelowHSP_WC.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.4 0.4])
title('WC responses to fast sine wave below set-point')

load('Fast_NearHSP_WC.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.4 0.4])
title('WC responses to fast sine wave near set-point')

load('Fast_AboveHSP_WC.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.4 0.4])
title('WC responses to fast sine wave above set-point')

load('Fast_BelowHSP_CC_A.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'c')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.6 0.8])
title('CC-A responses to fast sine wave below set-point')

load('Fast_NearHSP_CC_A.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'c')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.6 0.8])
title('CC-A responses to fast sine wave near set-point')

load('Fast_AboveHSP_CC_A.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'c')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.6 0.8])
title('CC-A responses to fast sine wave above set-point')

load('Fast_BelowHSP_CC_B.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'b')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.6 0.8])
title('CC-B responses to fast sine wave below set-point')

load('Fast_NearHSP_CC_B.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'b')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.6 0.8])
title('CC-B responses to fast sine wave near set-point')

load('Fast_AboveHSP_CC_B.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'b')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.6 0.8])
title('CC-B responses to fast sine wave above set-point')

%% Dataset for Fig 8 

load('Fast_AboveHSP_WC.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.6 0.8])
title('WC responses to fast sine wave above set-point')

load('Slow_AboveHSP_WC.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'r')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.6 0.8])
title('WC responses to slow wave above set-point')


load('Fast_AboveHSP_CC_A.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'c')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 48 -0.6 0.8])
title('CC-A responses to fast sine wave above set-point')

load('Slow_AboveHSP_CC_A.mat')
figure()
set(gcf,'Color','white')
shadedErrorBar(time, Avg_ca_resp ,ca_std_err,'c')
xlabel('time(s)')
ylabel('\DeltaF/F_o')
axis([0 120 -0.6 0.8])
title('CC-A responses to slow wave above set-point')


