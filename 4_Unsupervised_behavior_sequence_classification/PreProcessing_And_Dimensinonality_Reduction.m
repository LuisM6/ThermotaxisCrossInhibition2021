%% Generate 8 relevant metrics for IDT (iterative denoising trees) analysis used in Hernandez-Nunez et al 2021 Science Advances
% Author: Luis Hernandez Nunez
% Questions: luishernandeznunez@fas.harvard.edu
setupDirectories('utility functions')
addpath('C:\Program Files\MATLAB\R2016b\toolbox\stats');
clear all; close all; clc;
%% Input arguments
Genotypes            = {'w1118_sine_phase_15'; 'w1118_sine_phase_24';'w1118_sine_phase_30';'Ir68aPB_sine_phase_15'; 'Ir68aPB_sine_phase_24';'Ir68aPB_sine_phase_30';'Ir21a123_sine_phase_15';'Ir21a123_sine_phase_24';'Ir21a123_sine_phase_30'}  ;
Dates                = {'20180714';'20170728';'20180809';'20180717';'20180728';'20180810';'20181204';'20181205';'20181205'};
Type_of_stimulus    = 'Periodic_Activation';        %   periodic signal = Periodic_Activation  white noise = Random_Activation
Type_of_experiment  = 'Thermotaxis';                %   Thermotaxis Thermotaxis_with_optogenetics Chemotaxis Chemotaxis_with_optogenetics
Stimulus_period     = 96;                           %   in number of frames
Movie_duration      = 4800;                         %   in number of frames
Frame_rate          = 4;                            %   in Hz
Analysis_name       = 'Thermotaxis_Dataset';
%% LOAD additional files
all_tracks        =     [];
curr_dir          =     pwd;
fig_dir           =     ['\\LABNAS100\Luis\2018\',Type_of_experiment,'\_Results\',Analysis_name,'\'];
offsets_per_Genotype =  [0 0 0 0 0 0 10 10 10];   % When some movies are out of phase use this
offsets_per_track    =  [];   
for i=1:length(Genotypes)
    data_dir          =     ['\\LABNAS100\Luis\2018\',Type_of_experiment,'\',Genotypes{i},'\',Dates{i},'\',Type_of_stimulus];   
    cd(data_dir);
    eset              =     ExperimentSet.fromMatFiles([Genotypes{i},'_',Type_of_stimulus],'all',true);
    all_tracks        =     [all_tracks [eset.expt.track]];
    offsets_per_track =     [offsets_per_track offsets_per_Genotype(i)*ones(size([eset.expt.track]))];
end
cd(curr_dir);
%% Compute time traces of relevant quantities
l_speed         =   cell(length(all_tracks),1);
l_vel           =   cell(length(all_tracks),1);
l_spine         =   cell(length(all_tracks),1);
l_tail          =   cell(length(all_tracks),1);
l_head          =   cell(length(all_tracks),1);
l_loc           =   cell(length(all_tracks),1);
l_area          =   cell(length(all_tracks),1);
l_HeadTurn      =   cell(length(all_tracks),1);
l_HeadAngSpeed  =   cell(length(all_tracks),1);
l_startframe    =   zeros(length(all_tracks),1);
l_endframe      =   zeros(length(all_tracks),1);
%%
for i=1:length(all_tracks)
 if(isfield(all_tracks(i).dq,'sbodytheta'))
  l_speed{i}        =  all_tracks(i).dq.speed;
  l_vel{i}          =  all_tracks(i).dq.vel;  
  l_spine{i}        =  all_tracks(i).dq.ispine;  
  l_tail{i}         =  all_tracks(i).dq.itail;
  l_head{i}         =  all_tracks(i).dq.ihead;
  l_loc{i}          =  [all_tracks(i).pt.loc];
  l_area{i}         =  [all_tracks(i).pt.area]; 
  l_HeadTurn{i}     =  all_tracks(i).dq.sbodytheta;  
  l_HeadAngSpeed{i} =  all_tracks(i).dq.dsbodytheta;
  l_startframe(i)   =  all_tracks(i).startFrame+1;
  l_endframe(i)     =  all_tracks(i).endFrame;
 end 
end

initial_indexes = Stimulus_period/2*(1:2:(Movie_duration/Stimulus_period-1)*2);

sync_speed          = [];
sync_vel            = [];
sync_spine          = [];
sync_tail           = [];
sync_head           = [];
sync_loc            = [];
sync_area           = [];
sync_HeadTurn       = [];
sync_HeadAngSpeed   = [];

for i=1:length(all_tracks) 
 if(isfield(all_tracks(i).dq,'sbodytheta'))
  for j=3:length(initial_indexes)
    if(l_startframe(i)<(initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-1) && l_endframe(i)>(initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)))        
        sync_speed          = [sync_speed; l_speed{i}(initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-l_startframe(i):initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)-l_startframe(i))];        
        sync_vel            = [sync_vel; l_vel{i}(:,initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-l_startframe(i):initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)-l_startframe(i))];
        sync_spine          = [sync_spine; l_spine{i}(:,:,initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-l_startframe(i):initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)-l_startframe(i))];
        sync_tail           = [sync_tail; l_tail{i}(:,initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-l_startframe(i):initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)-l_startframe(i))];
        sync_head           = [sync_head; l_head{i}(:,initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-l_startframe(i):initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)-l_startframe(i))];
        sync_loc            = [sync_loc; l_loc{i}(:,initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-l_startframe(i)-1:1+initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)-l_startframe(i))];
        sync_area           = [sync_area; l_area{i}(initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-l_startframe(i):initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)-l_startframe(i))];
        sync_HeadTurn       = [sync_HeadTurn; l_HeadTurn{i}(initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-l_startframe(i):initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)-l_startframe(i))];
        sync_HeadAngSpeed   = [sync_HeadAngSpeed; l_HeadAngSpeed{i}(initial_indexes(j)-offsets_per_track(i)-Stimulus_period/4-l_startframe(i):initial_indexes(j)-offsets_per_track(i)+(3*Stimulus_period/4-1)-l_startframe(i))];
    end
  end
 end
end
        
% Compute rest of 8 metrics       
sync_CrabSpeed = zeros(size(sync_speed));
sync_length    = zeros(size(sync_speed));
sync_MotDir    = zeros(size(sync_speed));
sync_CrawlBias = zeros(size(sync_speed));

for i=1:size(sync_speed,1) 
    Flip_flag =0;
    for t = 1:size(sync_speed,2)
        a       = polyfit(sync_spine((i-1)*2+1,:,t),sync_spine((i-1)*2+2,:,t),1);
        s_p_uv  = [-sin(atan(a(1))), cos(atan(a(1)))];   
        sync_CrabSpeed(i,t)     =  dot([sync_vel((i-1)*2+1,t),sync_vel((i-1)*2+2,t)], s_p_uv);
        sync_length(i,t)        =  norm(sync_head((i-1)*2+1:(i-1)*2+2,t)-sync_spine((i-1)*2+1:(i-1)*2+2,11,t));
        for k= 11:-1:2
            sync_length(i,t)        =  sync_length(i,t) + norm(sync_spine((i-1)*2+1:(i-1)*2+2,k,t)-sync_spine((i-1)*2+1:(i-1)*2+2,k-1,t));
        end        
        sync_length(i,t)        =  sync_length(i,t) + norm(sync_spine((i-1)*2+1:(i-1)*2+2,1,t)-sync_tail((i-1)*2+1:(i-1)*2+2,t)); 
        
        b= sync_loc((i-1)*2+1:(i-1)*2+2,t+1)- sync_loc((i-1)*2+1:(i-1)*2+2,t); b = b./norm(b);
        c= sync_loc((i-1)*2+1:(i-1)*2+2,t+2)- sync_loc((i-1)*2+1:(i-1)*2+2,t+1); c = c./norm(c);
        sync_MotDir(i,t)        =  (1-dot(b,c))/2;   
        
        b= [sync_vel((i-1)*2+1,t),sync_vel((i-1)*2+2,t)]; 
        c= sync_head((i-1)*2+1:(i-1)*2+2,t) - sync_tail((i-1)*2+1:(i-1)*2+2,t); 
        sync_CrawlBias(i,t) = sign(dot(b,c)); 
    end    
end

% Now normalize parameters
for i=1:size(sync_speed,1)    
    sync_speed(i,:) = sync_speed(i,:)./mean(sync_speed(i,1:Stimulus_period/4-1));
    sync_CrabSpeed(i,:) = sync_CrabSpeed(i,:)./mean(sync_CrabSpeed(i,1:Stimulus_period/4-1));
    sync_HeadAngSpeed(i,:) = sync_HeadAngSpeed(i,:)./mean(sync_HeadAngSpeed(i,1:Stimulus_period/4-1));
    sync_area(i,:) = sync_area(i,:)./mean(sync_area(i,1:Stimulus_period/4-1));
    sync_length(i,:) = sync_length(i,:)./mean(sync_length(i,1:Stimulus_period/4-1));
end

%% Put 8 parameters in 1 huge matrix X
% The 8 parameters are
%  1 sync_speed
%  2 sync_CrabSpeed
%  3 sync_HeadTurn
%  4 sync_HeadAngSpeed
%  5 sync_area
%  6 sync_length
%  7 sync_MotDir
%  8 sync_CrawlBias


X = zeros(8,size(sync_speed,1),size(sync_speed,2)*3/4); % dim 1 = feature, dim 2 = track, dim 3 = time , 3/4 because 1/4th is before stimulus
X(1,:,:) = sync_speed(:,1:size(sync_speed,2)*3/4);
X(2,:,:) = sync_CrabSpeed(:,1:size(sync_speed,2)*3/4);
X(3,:,:) = sync_HeadTurn(:,1:size(sync_speed,2)*3/4);
X(4,:,:) = sync_HeadAngSpeed(:,1:size(sync_speed,2)*3/4);
X(5,:,:) = sync_area(:,1:size(sync_speed,2)*3/4);
X(6,:,:) = sync_length(:,1:size(sync_speed,2)*3/4);
X(7,:,:) = sync_MotDir(:,1:size(sync_speed,2)*3/4);
X(8,:,:) = sync_CrawlBias(:,1:size(sync_speed,2)*3/4);

%% Smooth with a polynomial smoothing spline all the values of X

for i=1:size(sync_speed,1)
 for j=1:size(X,1)
    if(sum(isnan(squeeze(X(j,i,:))))>0)
       nanData = isnan(squeeze(X(j,i,:)));
       temp = squeeze(X(j,i,:));
       index   = 1:numel(temp);
       temp(isnan(temp)) = interp1(index(~nanData), temp(~nanData), index(nanData)); 
       F = fit([1:72]',temp,'smoothingspline'); 
    else
       F = fit([1:72]',squeeze(X(j,i,:)),'smoothingspline'); 
    end
    
    X(j,i,:) = F(1:72);
 end
end

%% Compute the weigth according to the Vogelstein et al paper
w = zeros(1,size(X,1));
M = zeros(size(X,1),size(X,2),size(X,2));

for g=1:size(X,1)
    for i=1:size(X,2)-1
        for j=i+1:size(X,2)
            M(g,i,j) = trapz(0:0.25:17.75,(X(g,i,:)-X(g,j,:)).*(X(g,i,:)-X(g,j,:)));
            M(g,j,i) = M(g,i,j);
        end
    end
    w(g) = 1/(max(max(M(g,:,:))));
end

%% Compute dissimilarity matrix
D = zeros(size(X,2));

for i=1:size(X,2)-1
    for j=i+1:size(X,2)
        D(i,j) = sum(w.*squeeze(M(:,i,j))').^0.5;
        D(j,i) = D(i,j);
    end
end

%% Embed in euclidean space using classic multidimensional scaling
[Y,e] = cmdscale(D);
%% Select number of dimensions using scree test criterion
figure();bar(e(1:10))
% based on the scree plot 3 dimensions should be used
dat = Y(:,1:3);
%% This is all, now save Y as txt so it can be opened in R code
mkdir(fig_dir)
cd(fig_dir)
dlmwrite('EmbededDM.txt',dat)
save('Eight_metrics.mat','sync_speed', 'sync_CrabSpeed', 'sync_HeadTurn', 'sync_HeadAngSpeed', 'sync_area', 'sync_length', 'sync_MotDir', 'sync_CrawlBias')
cd(curr_dir)

