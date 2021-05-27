%% Behaviotypes movies and supplementary analysis used in Hernandez-Nunez et al 2021 Science Advances
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
Leafs_file          = 'Thermotaxis_Leafs.txt';      %   Output of Interative denoising trees clustering ran in R
%% Load experiment set
all_tracks        =     [];
n_eff_tracks      =     zeros(length(Genotypes),1);
n_eff_tracks_per_G=     cell(length(Genotypes),1);
initial_indexes   =     Stimulus_period/2*(1:2:(Movie_duration/Stimulus_period-1)*2);
curr_dir          =     pwd;
fig_dir           =     ['\\LABNAS100\Luis\2018\',Type_of_experiment,'\_Results\',Analysis_name,'\'];
for i=1:length(Genotypes)
    data_dir          =     ['\\LABNAS100\Luis\2018\',Type_of_experiment,'\',Genotypes{i},'\',Dates{i},'\',Type_of_stimulus];   
    cd(data_dir);
    eset              =     ExperimentSet.fromMatFiles([Genotypes{i},'_',Type_of_stimulus],'all',true);
    temp              =     [eset.expt.track];
    all_tracks        =     [all_tracks temp];
    
    n_eff_tracks_per_G{i} = zeros(length(eset.expt),1);
    
    l_startframe    =   zeros(length(temp),1);
    l_endframe      =   zeros(length(temp),1);
    for ii=1:length(temp)
        if(isfield(temp(ii).dq,'sbodytheta'))  
            l_startframe(ii)   =  temp(ii).startFrame+1;
            l_endframe(ii)     =  temp(ii).endFrame;
        end
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
          
    for ii=1:length(temp) 
        if(isfield(temp(ii).dq,'sbodytheta'))
            for jj=3:length(initial_indexes)
                if(l_startframe(ii)<(initial_indexes(jj)-Stimulus_period/4-1) && l_endframe(ii)>(initial_indexes(jj)+(3*Stimulus_period/4-1)))        
                     n_eff_tracks(i)= n_eff_tracks(i)+1;
                     % remove in the future
                     if(i==1)
                        n_eff_tracks_per_G{i}(str2num(temp(ii).expt.fname(end-4))-2) = n_eff_tracks_per_G{i}(str2num(temp(ii).expt.fname(end-4))-2)+1;
                     elseif(i==7 || i==9)
                         if(str2num(temp(ii).expt.fname(end-4))==3)
                            n_eff_tracks_per_G{i}(2) = n_eff_tracks_per_G{i}(2)+1;  
                         else
                            n_eff_tracks_per_G{i}(str2num(temp(ii).expt.fname(end-4))) = n_eff_tracks_per_G{i}(str2num(temp(ii).expt.fname(end-4)))+1; 
                         end
                     elseif(i==8)
                         n_eff_tracks_per_G{i}(str2num(temp(ii).expt.fname(end-4))-1) = n_eff_tracks_per_G{i}(str2num(temp(ii).expt.fname(end-4))-1)+1;
                     else
                        n_eff_tracks_per_G{i}(str2num(temp(ii).expt.fname(end-4))) = n_eff_tracks_per_G{i}(str2num(temp(ii).expt.fname(end-4)))+1;
                     end
                end
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    end    
end
cd(curr_dir);
%% LOAD file with leafs and read the leafs
curr_dir          =     pwd;
cd(fig_dir)
fid1 = fopen(Leafs_file,'r');
cd(curr_dir)
%% Get number of leaves
fseek(fid1, 0, 'eof');
fileSize = ftell(fid1);
frewind(fid1);
% Read the whole file.
data = fread(fid1, fileSize, 'uint8');
% Count number of line-feeds and increase by one.
numLeaves = sum(data == 10)/4;
fclose(fid1);
%% Get leave names and content
cd(fig_dir)
fid1 = fopen(Leafs_file,'r');
cd(curr_dir)
Leaves_names    = cell(numLeaves,1);
Leaves_content  = cell(numLeaves,1);
Leaves_level    = zeros(numLeaves,1);
isLeaf          = cell(numLeaves,1);
for i=1:numLeaves
    line = fgets(fid1);
    Leaves_level(i) = sscanf(line, '%i');
    line = fgets(fid1);
    Leaves_names{i} = sscanf(line, '%i');
    line = fgets(fid1);
    Leaves_content{i} = sscanf(line, '%i');
    line = fgets(fid1);
    isLeaf{i} = sscanf(line, '%s');
end
fclose(fid1);
%% Get all the branches content (not only leaves content)
tree_spine_vec = ones(max(Leaves_level),1);
for i=2:length(tree_spine_vec)
    tree_spine_vec(i)=2*tree_spine_vec(i-1);
end
% Get total branches in the tree, assuming no more than 1 level imbalance
max_possible_branches= 0;
for i=1:max(Leaves_level)
    if(any((Leaves_level<i)))
      max_possible_branches = max_possible_branches+tree_spine_vec(i)-sum(Leaves_level<i)*2;  
    else
      max_possible_branches = max_possible_branches+tree_spine_vec(i);
    end
end

% Initialize content of each branch
B_content      = cell(max_possible_branches,1);
% Fill matrixes for each branch
B_counter = 1;
curr_branch = 1; prev_branch = 1;
lnames = Leaves_names;
for j=1:max(Leaves_level)-1     
    for i=1:numLeaves
        curr_branch = floor(lnames{i}/10^(Leaves_level(i)-j));
        if(j==max(Leaves_level)-1)&&(j==Leaves_level(i))
            B_counter=B_counter+1;
        else
            B_counter = B_counter+(curr_branch~=prev_branch);
        end
        B_content{B_counter} = [B_content{B_counter}; Leaves_content{i}];
        lnames{i} = lnames{i} - floor(lnames{i}/10^(Leaves_level(i)-j))*10^(Leaves_level(i)-j);
        prev_branch = curr_branch;
    end
    if(curr_branch==floor(lnames{1}/10^(Leaves_level(1)-j-1)))
        B_counter = B_counter+1;
    end
end
   
for i =1:length(Leaves_level)
    if(Leaves_level(i)==max(Leaves_level))
        B_counter = B_counter+1;
        B_content{B_counter} = Leaves_content{i};        
    end
end
num_branches = B_counter;

%% Match track with animal number
l_startframe    =   zeros(length(all_tracks),1);
l_endframe      =   zeros(length(all_tracks),1);
for i=1:length(all_tracks)
 if(isfield(all_tracks(i).dq,'sbodytheta'))
  l_startframe(i)   =  all_tracks(i).startFrame;
  l_endframe(i)     =  all_tracks(i).endFrame;
 end 
end
initial_indexes = Stimulus_period/2*(1:2:(Movie_duration/Stimulus_period-1)*2);
all_responses_inds = zeros(length(length(B_content{1})),2);
all_responses_track= zeros(1,length(length(B_content{1})));
all_responses_movie= zeros(1,length(length(B_content{1})));
count = 1;
for i=1:length(all_tracks) 
  if(isfield(all_tracks(i).dq,'sbodytheta'))
    for j=3:length(initial_indexes)  
        if(l_startframe(i)<(initial_indexes(j)-Stimulus_period/4-1) && l_endframe(i)>(initial_indexes(j)+(3*Stimulus_period/4-1)))
            all_responses_inds(count,:) = [initial_indexes(j)-Stimulus_period/4-1, initial_indexes(j)+(3*Stimulus_period/4-1)];
            all_responses_track(1,count) = i;
            
            
            t_gn = 1;
            for ii = 2:length(n_eff_tracks)
                if (count>sum(n_eff_tracks(1:ii-1)) &&  count<=sum(n_eff_tracks(1:ii)))
                    t_gn=ii;
                    movie_number = 1;
                    for jj=2:length(n_eff_tracks_per_G{t_gn}) 
                        if(count>sum(n_eff_tracks(1:t_gn-1))+sum(n_eff_tracks_per_G{t_gn}(1:jj-1))  &&  count<=sum(n_eff_tracks(1:t_gn-1))+sum(n_eff_tracks_per_G{t_gn}(1:jj)))
                            movie_number = jj;
                        end
                    end        
                end
            end
            
            if(t_gn==1)
                movie_number = 1;
                    for jj=2:length(n_eff_tracks_per_G{t_gn}) 
                        if(count>sum(n_eff_tracks_per_G{t_gn}(1:jj-1))  &&  count<=sum(n_eff_tracks_per_G{t_gn}(1:jj)))
                            movie_number = jj;
                        end
                    end     
            end
            
        
            all_responses_movie(1,count) = movie_number;
            count = count+1;
        end
    end
  end
end
%% Make 10 movies of each branch, any number of movies can be selected

imOptions = {'pretty', true, 'drawContour', true, 'scale', 1,'contourColor', 'm-', 'LineWidth', 1, 'mhWidth', 2};
outres = [640 480];
p = get(gcf, 'Position');
p(1) = max(p(1)+p(3)-outres(1), 1);
p(2) = max(p(2)+p(4)-outres(2), 1);
p(3:4) = outres;
avirect = [0 0 outres(1) outres(2)];
textoptions = {'FontName', 'Arial', 'FontWeight', 'bold'};

for i =num_branches-15:num_branches
  for k=1:10
    
      genotype_num = 1;
      for jj = 2:length(n_eff_tracks)
        if (B_content{i}(k)>sum(n_eff_tracks(1:jj-1)) &&  B_content{i}(k)<=sum(n_eff_tracks(1:jj)))
            genotype_num = jj;
        end
      end
      
    
    vidObj.FrameRate = Frame_rate;
    vidObj.Quality = 90;
    vidObj = VideoWriter([fig_dir,'\branch_',num2str(i),'_animal_',num2str(k)]);
    open(vidObj);   
    set(gcf, 'Position', p);
 
    inds = int16(all_responses_inds(B_content{i}(k),1):all_responses_inds(B_content{i}(k),2))-all_tracks(all_responses_track(B_content{i}(k))).startFrame;
    ptinds = all_tracks(all_responses_track(B_content{i}(k))).getDerivedQuantity('mapinterpedtopts', false, inds);
    pt = all_tracks(all_responses_track(B_content{i}(k))).pt;
    
    ax = gca;
    f = get(ax, 'Parent');
    curr_f=figure(f);

    sl = double(all_tracks(all_responses_track(B_content{i}(k))).getDerivedQuantity('sloc', false, inds));
    ll = min(sl,[],2);
    ur = max(sl,[],2);
    rect = [ll(1)*1.1-ur(1)*0.1 ur(1)*1.1-ll(1)*0.1 ll(2)*1.1-ur(2)*0.1 ur(2)*1.1-ll(2)*0.1];      
    
    rect = [rect(1)-60 rect(2)+60 rect(3)-60 rect(4)+60];    
    
    si = max(min(max(inds)-120, min(inds)), 1);
    ei = min(max(min(inds)+120, max(inds)), length(all_tracks(all_responses_track(B_content{i}(k))).dq.eti));

    
    
    for j = 1:length(inds)
        
        im_data = imread(['\\LABNAS100\Luis\2018\',Type_of_experiment,'\',Genotypes{genotype_num},'\',Dates{genotype_num},'\t10',num2str(all_responses_movie(B_content{i}(k))),'\Im_',num2str(ptinds(j)-1+all_tracks(all_responses_track(B_content{i}(k))).startFrame),'.jpg']);
        imagesc(im_data);
        axis(rect)
        colormap(gray);
        hold on
        pt(ptinds(j)).drawTrackImage(all_tracks(all_responses_track(B_content{i}(k))).expt.camcalinfo, 'fid', all_tracks(all_responses_track(B_content{i}(k))).expt.fid, imOptions{:}, 'pretty', true, 'drawContour', true, 'drawSpine', 1); 
        si = max(min(max(inds)-120, min(inds)), 1);
        ei = min(max(min(inds)+120, max(inds)), length(all_tracks(all_responses_track(B_content{i}(k))).dq.eti));
        all_tracks(all_responses_track(B_content{i}(k))).plotPath('sloc', 'g.', 'inds', si:ei, 'LineWidth', 2, 'MarkerSize', 3);
        pause(0.25);
        numwrites = 1;
        if (~isempty(vidObj))
            if (~isempty(avirect))
                currFrame = getframe(f);
            else
                currFrame = getframe(f,avirect);
            end
            for kk = 1:numwrites
                writeVideo(vidObj,currFrame);
            end
       else
            for kk = 1:numwrites
                pause(0.04);
            end
        end      
        
    end
    
    if (~isempty(vidObj))
        close(vidObj);
        vidObj = [];
    end
    close all
  end
end
    




%% Make heat map of behavioral outputs (this is Supplementary Fig. 7)
Genotype_to_branch_mat = zeros(length(Genotypes),16);

for i =num_branches-15:num_branches
  for k=1:length(B_content{i})   
    if(B_content{i}(k)>0 &&  B_content{i}(k)<=n_eff_tracks(1))
       Genotype_to_branch_mat(1,i-15) = Genotype_to_branch_mat(1,i-15)+1; 
    else
      for jj = 2:length(n_eff_tracks)
        if (B_content{i}(k)>sum(n_eff_tracks(1:jj-1)) &&  B_content{i}(k)<=sum(n_eff_tracks(1:jj)))
            Genotype_to_branch_mat(jj,i-15) = Genotype_to_branch_mat(jj,i-15)+1;         
        end
      end
    end
  end
end

for i=1:length(Genotypes)
    Genotype_to_branch_mat(i,:) = Genotype_to_branch_mat(i,:)./ sum(Genotype_to_branch_mat(i,:));
end
    
figure()
imagesc(Genotype_to_branch_mat)
ax = gca;
ax.Visible = 'off';
%% Make comparison matrix plot (this is Supplementary Fig. 8)
figure()
set(gcf,'Color','White')
for i=1:16
    subplot(4,4,i);
    %Plot w1118
    plot(Genotype_to_branch_mat(1:3,i),'s','MarkerFaceColor','g','MarkerEdgeColor','g')
    hold on
    plot(Genotype_to_branch_mat(1:3,i),'g','LineWidth',1.5)
    % Plot Ir68a1
    plot(Genotype_to_branch_mat(4:6,i),'s','MarkerFaceColor','b','MarkerEdgeColor','b')
    hold on
    plot(Genotype_to_branch_mat(4:6,i),'b','LineWidth',1.5)
    % Plot Ir21a1
    plot(Genotype_to_branch_mat(7:9,i),'s','MarkerFaceColor','r','MarkerEdgeColor','r')
    hold on
    plot(Genotype_to_branch_mat(7:9,i),'r','LineWidth',1.5)
    axis([0.6 3.4 0 max(Genotype_to_branch_mat(:,i))*2.0])
end
