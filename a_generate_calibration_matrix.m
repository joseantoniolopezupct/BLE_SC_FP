%% PROCESAMIENTO DE CANALES DE FORMA INDEPENDIENTE
%Poner una ruta de carpeta para los archivos de los 3 canales y otra para
%multicanal
clear all
close all
clc


%% Load equalization vectors from both antennas
load('equalization_vector_antenna1.mat')
equalization_vector_antenna1 = -vector_ecualizacion;
load('equalization_vector_antenna2.mat')
equalization_vector_antenna2 = -vector_ecualizacion;

%% Matrix employed later for plotting RSSI
lwa1_P1_37 = zeros();
lwa1_P1_38 = zeros();
lwa1_P1_39 = zeros();
lwa1_P2_37 = zeros();
lwa1_P2_38 = zeros();
lwa1_P2_39 = zeros();
lwa2_P1_37 = zeros();
lwa2_P1_38 = zeros();
lwa2_P1_39 = zeros();
lwa2_P2_37 = zeros();
lwa2_P2_38 = zeros();
lwa2_P2_39 = zeros();
monp1_37 = zeros();
monp1_38 = zeros();
monp1_39 = zeros();
monp2_37 = zeros();
monp2_38 = zeros();
monp2_39 = zeros();
monp3_37 = zeros();
monp3_38 = zeros();
monp3_39 = zeros();
monp4_37 = zeros();
monp4_38 = zeros();
monp4_39 = zeros();


%% Generate a vector with filenames in the calibration folder
filename = {};
files =dir('Calibration_21112023/');
i=1;
for k=1:length(files)
    if length(files(k).name)>3
        filename{i}= files(k).name;
        i=i+1;
    end
end

%% Load RSSI from files to generate the calibration matrix
% We generate a different row of the calibration matrix per each file
for z=1:length(filename)
   
    k = strsplit(filename{z},'_');
    
    %X and Y coordinates 
    X = str2num(k{3});
    ytext = split(k{5},'.');
    Y =  str2num(ytext{1});
    
    dataraw = importdata(strcat('Calibration_21112023/',filename{z}), ';' );

    port1 = find(strcmp(dataraw.textdata(:,2),'P1'));
    port2 = find(strcmp(dataraw.textdata(:,2),'P2'));
    port3 = find(strcmp(dataraw.textdata(:,2),'P3'));
    port4 = find(strcmp(dataraw.textdata(:,2),'P4'));
    port5 = find(strcmp(dataraw.textdata(:,2),'P5'));
    port6 = find(strcmp(dataraw.textdata(:,2),'P6'));
    port7 = find(strcmp(dataraw.textdata(:,2),'P7'));
    port8 = find(strcmp(dataraw.textdata(:,2),'P8'));
    
    data_port1 = dataraw.data(port1,:);
    data_port2 = dataraw.data(port2,:);
    data_port3 = dataraw.data(port3,:);
    data_port4 = dataraw.data(port4,:);
    data_port5 = dataraw.data(port5,:);
    data_port6 = dataraw.data(port6,:);
    data_port7 = dataraw.data(port7,:);
    data_port8 = dataraw.data(port8,:);
   
    % RSSI data for SC
    index_data_port1_37 = find(data_port1(:,1) == 37);
    index_data_port1_38 = find(data_port1(:,1) == 38);
    index_data_port1_39 = find(data_port1(:,1) == 39);
    index_data_port2_37 = find(data_port2(:,1) == 37);
    index_data_port2_38 = find(data_port2(:,1) == 38);
    index_data_port2_39 = find(data_port2(:,1) == 39);
    index_data_port3_37 = find(data_port3(:,1) == 37);
    index_data_port3_38 = find(data_port3(:,1) == 38);
    index_data_port3_39 = find(data_port3(:,1) == 39);
    index_data_port4_37 = find(data_port4(:,1) == 37);
    index_data_port4_38 = find(data_port4(:,1) == 38);
    index_data_port4_39 = find(data_port4(:,1) == 39);
    index_data_port5_37 = find(data_port5(:,1) == 37);
    index_data_port5_38 = find(data_port5(:,1) == 38);
    index_data_port5_39 = find(data_port5(:,1) == 39);
    index_data_port6_37 = find(data_port6(:,1) == 37);
    index_data_port6_38 = find(data_port6(:,1) == 38);
    index_data_port6_39 = find(data_port6(:,1) == 39);
    index_data_port7_37 = find(data_port7(:,1) == 37);
    index_data_port7_38 = find(data_port7(:,1) == 38);
    index_data_port7_39 = find(data_port7(:,1) == 39);
    index_data_port8_37 = find(data_port8(:,1) == 37);
    index_data_port8_38 = find(data_port8(:,1) == 38);
    index_data_port8_39 = find(data_port8(:,1) == 39);
    
    rssi_port1_37 = mean(data_port1(index_data_port1_37,2));
    rssi_port1_38 = mean(data_port1(index_data_port1_38,2));
    rssi_port1_39 = mean(data_port1(index_data_port1_39,2));
    rssi_port2_37 = mean(data_port2(index_data_port2_37,2));
    rssi_port2_38 = mean(data_port2(index_data_port2_38,2));
    rssi_port2_39 = mean(data_port2(index_data_port2_39,2));
    rssi_port3_37 = mean(data_port3(index_data_port3_37,2));
    rssi_port3_38 = mean(data_port3(index_data_port3_38,2));
    rssi_port3_39 = mean(data_port3(index_data_port3_39,2));
    rssi_port4_37 = mean(data_port4(index_data_port4_37,2));
    rssi_port4_38 = mean(data_port4(index_data_port4_38,2));
    rssi_port4_39 = mean(data_port4(index_data_port4_39,2));
    rssi_port5_37 = mean(data_port5(index_data_port5_37,2));
    rssi_port5_38 = mean(data_port5(index_data_port5_38,2));
    rssi_port5_39 = mean(data_port5(index_data_port5_39,2));
    rssi_port6_37 = mean(data_port6(index_data_port6_37,2));
    rssi_port6_38 = mean(data_port6(index_data_port6_38,2));
    rssi_port6_39 = mean(data_port6(index_data_port6_39,2));
    rssi_port7_37 = mean(data_port7(index_data_port7_37,2));
    rssi_port7_38 = mean(data_port7(index_data_port7_38,2));
    rssi_port7_39 = mean(data_port7(index_data_port7_39,2));
    rssi_port8_37 = mean(data_port8(index_data_port8_37,2));
    rssi_port8_38 = mean(data_port8(index_data_port8_38,2));
    rssi_port8_39 = mean(data_port8(index_data_port8_39,2));
    
    % RSSI data for UC
    rssi_port1_UC = mean(data_port1(:,2));
    rssi_port2_UC = mean(data_port2(:,2));
    rssi_port3_UC = mean(data_port3(:,2));
    rssi_port4_UC = mean(data_port4(:,2));
    
    rssi_port5_UC = mean(data_port5(:,2));
    rssi_port6_UC = mean(data_port6(:,2));
    rssi_port7_UC = mean(data_port7(:,2));
    rssi_port8_UC = mean(data_port8(:,2));

    %Points changed from (-5,-6)-(5,6) to (1,1)-(10-13) for Matlab index
    if(X<0)
        X = X+6;
    else
        X = X+5;
    end
    Y = Y+7;

    %SCFP Calibration vector for LWA --> Ports from #1 to #4 and different
    %channels
    LWA_SC_name_vector = sprintf('x_%d_y_%d_LWA_SC', X, Y);
    LWA_SC_RSSI_vector = [rssi_port1_37, rssi_port2_37, rssi_port1_38, rssi_port2_38, rssi_port1_39, rssi_port2_39, rssi_port3_37, rssi_port4_37, rssi_port3_38, rssi_port4_38, rssi_port3_39, rssi_port4_39];
    eval([LWA_SC_name_vector ' = LWA_SC_RSSI_vector;']);

    %SCFP Calibration vector for Monpoles --> Ports from #5 to #8
    Monopole_SC_name_vector = sprintf('x_%d_y_%d_Monopole_SC', X, Y);
    Monopole_SC_RSSI_vector = [rssi_port5_37, rssi_port6_37, rssi_port5_38, rssi_port6_38, rssi_port5_39, rssi_port6_39, rssi_port7_37, rssi_port8_37, rssi_port7_38, rssi_port8_38, rssi_port7_39, rssi_port8_39];
    eval([Monopole_SC_name_vector ' = Monopole_SC_RSSI_vector;']);

    %UCFP Calibration vector for LWA --> Ports from #1 to #4 and channels
    %unified 
    LWA_UC_name_vector = sprintf('x_%d_y_%d_LWA_UC', X, Y);
    LWA_UC_RSSI_vector = [rssi_port1_UC, rssi_port2_UC, rssi_port3_UC, rssi_port4_UC];
    eval([LWA_UC_name_vector ' = LWA_UC_RSSI_vector;']);
    
    %UCFP Calibration vector for Monpoles --> Ports from #5 to #8 and
    %channels unified
    Monopole_UC_name_vector = sprintf('x_%d_y_%d_Monopole_UC', X, Y);
    Monopole_UC_RSSI_vector = [rssi_port5_UC, rssi_port6_UC, rssi_port7_UC, rssi_port8_UC];
    eval([Monopole_UC_name_vector ' = Monopole_UC_RSSI_vector;']);

    %Matrix generation for ploting RSSI figures
    lwa1_P1_37(Y,X) = rssi_port1_37;
    lwa1_P1_38(Y,X) = rssi_port1_38;
    lwa1_P1_39(Y,X) = rssi_port1_39;
    lwa1_P2_37(Y,X) = rssi_port2_37;
    lwa1_P2_38(Y,X) = rssi_port2_38;
    lwa1_P2_39(Y,X) = rssi_port2_39;
    lwa2_P1_37(Y,X) = rssi_port3_37;
    lwa2_P1_38(Y,X) = rssi_port3_38;
    lwa2_P1_39(Y,X) = rssi_port3_39;
    lwa2_P2_37(Y,X) = rssi_port4_37;
    lwa2_P2_38(Y,X) = rssi_port4_38;
    lwa2_P2_39(Y,X) = rssi_port4_39;
    monp1_37(Y,X) = rssi_port5_37;
    monp1_38(Y,X) = rssi_port5_38;
    monp1_39(Y,X) = rssi_port5_39;
    monp2_37(Y,X) = rssi_port6_37;
    monp2_38(Y,X) = rssi_port6_38;
    monp2_39(Y,X) = rssi_port6_39;
    monp3_37(Y,X) = rssi_port7_37;
    monp3_38(Y,X) = rssi_port7_38;
    monp3_39(Y,X) = rssi_port7_39;
    monp4_37(Y,X) = rssi_port8_37;
    monp4_38(Y,X) = rssi_port8_38;
    monp4_39(Y,X) = rssi_port8_39;
end 

%% The x_%d_y_%d_LWA_SC vectors are iterated for generate the LWA_SC_Calibration_Matrix
LWA_SC_Calibration_Matrix = zeros(130, 12);
LWA_SC_index = 1;
for i= 1:10
    for j= 1:13
        LWA_SC_row_vector = sprintf('x_%d_y_%d_LWA_SC', i, j);
        LWA_SC_selected_vector = eval(LWA_SC_row_vector);
        LWA_SC_Calibration_Matrix(LWA_SC_index, :) = LWA_SC_selected_vector;
        LWA_SC_index = LWA_SC_index + 1;
    end
end

% The LWA RSSI is equalized in the SC case
LWA_SC_Calibration_Matrix(:,1) = LWA_SC_Calibration_Matrix(:,1)+equalization_vector_antenna1(1);
LWA_SC_Calibration_Matrix(:,2) = LWA_SC_Calibration_Matrix(:,2)+equalization_vector_antenna1(4);
LWA_SC_Calibration_Matrix(:,3) = LWA_SC_Calibration_Matrix(:,3)+equalization_vector_antenna1(2);
LWA_SC_Calibration_Matrix(:,4) = LWA_SC_Calibration_Matrix(:,4)+equalization_vector_antenna1(5);
LWA_SC_Calibration_Matrix(:,5) = LWA_SC_Calibration_Matrix(:,5)+equalization_vector_antenna1(3);
LWA_SC_Calibration_Matrix(:,6) = LWA_SC_Calibration_Matrix(:,6)+equalization_vector_antenna1(6);

LWA_SC_Calibration_Matrix(:,7) = LWA_SC_Calibration_Matrix(:,7)+equalization_vector_antenna2(1);
LWA_SC_Calibration_Matrix(:,8) = LWA_SC_Calibration_Matrix(:,8)+equalization_vector_antenna2(4);
LWA_SC_Calibration_Matrix(:,9) = LWA_SC_Calibration_Matrix(:,9)+equalization_vector_antenna2(2);
LWA_SC_Calibration_Matrix(:,10) = LWA_SC_Calibration_Matrix(:,10)+equalization_vector_antenna2(5);
LWA_SC_Calibration_Matrix(:,11) = LWA_SC_Calibration_Matrix(:,11)+equalization_vector_antenna2(3);
LWA_SC_Calibration_Matrix(:,12) = LWA_SC_Calibration_Matrix(:,12)+equalization_vector_antenna2(6);

%Saving LWA_SC_Calibration_Matrix into a .mat file
save('LWA_SC_Calibration_matrix.mat','LWA_SC_Calibration_Matrix');

%% The x_%d_y_%d_Monopole_SC vectors are iterated for generate the Monopole_SC_Calibration_Matrix
Monopole_SC_Calibration_Matrix = zeros(130, 12);
Monopole_SC_index = 1;
for i= 1:10
    for j= 1:13
        Monopole_SC_row_vector = sprintf('x_%d_y_%d_Monopole_SC', i, j);
        Monopole_SC_selected_vector = eval(Monopole_SC_row_vector);
        Monopole_SC_Calibration_Matrix(Monopole_SC_index, :) = Monopole_SC_selected_vector;
        Monopole_SC_index = Monopole_SC_index + 1;
    end
end

%Saving Monopoles_SC_Calibration_Matrix into a .mat file
save('Monopoles_SC_Calibration_matrix.mat','Monopole_SC_Calibration_Matrix');

%% The x_%d_y_%d_LWA_UC vectors are iterated for generate the LWA_UC_Calibration_Matrix
LWA_UC_Calibration_Matrix = zeros(130, 4);
LWA_UC_index = 1;
for i= 1:10
    for j= 1:13
        LWA_UC_row_vector = sprintf('x_%d_y_%d_LWA_UC', i, j);
        LWA_UC_selected_vector = eval(LWA_UC_row_vector);
        LWA_UC_Calibration_Matrix(LWA_UC_index, :) = LWA_UC_selected_vector;
        LWA_UC_index = LWA_UC_index + 1;
    end
end

%Saving LWA_UC_Calibration_Matrix into a .mat file
save('LWA_UC_Calibration_matrix.mat','LWA_UC_Calibration_Matrix');

%% The x_%d_y_%d_Monopole_UC vectors are iterated for generate the Monopole_UC_Calibration_Matrix
Monopole_UC_Calibration_Matrix = zeros(130, 4);
Monopole_UC_index = 1;
for i= 1:10
    for j= 1:13
        Monopole_UC_row_vector = sprintf('x_%d_y_%d_Monopole_UC', i, j);
        Monopole_UC_selected_vector = eval(Monopole_UC_row_vector);
        Monopole_UC_Calibration_Matrix(Monopole_UC_index, :) = Monopole_UC_selected_vector;
        Monopole_UC_index = Monopole_UC_index + 1;
    end
end

%Saving Monopoles_SC_Calibration_Matrix into a .mat file
save('Monopoles_UC_Calibration_matrix.mat','Monopole_UC_Calibration_Matrix');

%% Generation of axis ticks
xtick = 50;
ytick = 50;
ejeX = -4.5*xtick:xtick:4.5*xtick;
ejeY = -6*ytick:ytick:6*ytick;

for i=1:length(ejeX)
    valueX{i}=sprintf('%d',ejeX(i));
end
for i=1:length(ejeY)
    valueY{i}=sprintf('%d',ejeY(i));
end
valueX = flip(valueX);
valueY = flip(valueY);

%% Generate the colormap for the figures
num_levels = 8;
% Red color levels
red = linspace(0, 1, num_levels)';
green = zeros(num_levels, 1);
blue = zeros(num_levels, 1);
colors_red = [red, green, blue];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Green color levels
red = zeros(num_levels, 1);
green = linspace(0, 1, num_levels)';
blue = zeros(num_levels, 1);
colors_green = [red, green, blue];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Blue color levels
red = linspace(0, 0.1, num_levels)';
green = linspace(0, 0.26, num_levels)';
blue = linspace(0, 1, num_levels)';
colors_blue = [red, green, blue];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plot the different SC RSSI level figures for LWA1
figure;
set(gcf, 'color', 'w'); % Fondo blanco

% LWA1 #37 Port 1
subplot(2, 3, 1);
h1 = heatmap(valueX, valueY, flip(lwa1_P1_37), 'Colormap', colors_red, 'CellLabelColor', 'none');
h1.Title = 'LWA1 P1 Ch37 RSSI (dB)';
h1.XLabel = 'cm';
h1.YLabel = 'cm';
h1.FontSize = 16;
h1.ColorLimits = [-50 -30]; % Equivalente a caxis
s1 = struct(h1);
s1.XAxis.TickLabelRotation = 0;

% LWA1 #38 Port 1
subplot(2, 3, 2);
h2 = heatmap(valueX, valueY, flip(lwa1_P1_38), 'Colormap', colors_green, 'CellLabelColor', 'none');
h2.Title = 'LWA1 P1 Ch38 RSSI (dB)';
h2.XLabel = 'cm';
h2.YLabel = 'cm';
h2.FontSize = 16;
h2.ColorLimits = [-50 -30];
s2 = struct(h2);
s2.XAxis.TickLabelRotation = 0;

% LWA1 #39 Port 1
subplot(2, 3, 3);
h3 = heatmap(valueX, valueY, flip(lwa1_P1_39), 'Colormap', colors_blue, 'CellLabelColor', 'none');
h3.Title = 'LWA1 P1 Ch39 RSSI (dB)';
h3.XLabel = 'cm';
h3.YLabel = 'cm';
h3.FontSize = 16;
h3.ColorLimits = [-50 -30];
s3 = struct(h3);
s3.XAxis.TickLabelRotation = 0;

% LWA1 #37 Port 2
subplot(2, 3, 4);
h4 = heatmap(valueX, valueY, flip(lwa1_P2_37), 'Colormap', colors_red, 'CellLabelColor', 'none');
h4.Title = 'LWA1 P2 Ch37 RSSI (dB)';
h4.XLabel = 'cm';
h4.YLabel = 'cm';
h4.FontSize = 16;
h4.ColorLimits = [-50 -30];
s4 = struct(h4);
s4.XAxis.TickLabelRotation = 0;

% LWA1 #38 Port 2
subplot(2, 3, 5);
h5 = heatmap(valueX, valueY, flip(lwa1_P2_38), 'Colormap', colors_green, 'CellLabelColor', 'none');
h5.Title = 'LWA1 P2 Ch38 RSSI (dB)';
h5.XLabel = 'cm';
h5.YLabel = 'cm';
h5.FontSize = 16;
h5.ColorLimits = [-50 -30];
s5 = struct(h5);
s5.XAxis.TickLabelRotation = 0;

% LWA1 #39 Port 2
subplot(2, 3, 6);
h6 = heatmap(valueX, valueY, flip(lwa1_P2_39), 'Colormap', colors_blue, 'CellLabelColor', 'none');
h6.Title = 'LWA1 P2 Ch39 RSSI (dB)';
h6.XLabel = 'cm';
h6.YLabel = 'cm';
h6.FontSize = 16;
h6.ColorLimits = [-50 -30];
s6 = struct(h6);
s6.XAxis.TickLabelRotation = 0;



%% Plot the different SC RSSI level figures for LWA2
figure;
set(gcf, 'color', 'w'); % Fondo blanco

% LWA2 #37 Port 1
subplot(2, 3, 1);
h1 = heatmap(valueX, valueY, flip(lwa2_P1_37), 'Colormap', colors_red, 'CellLabelColor', 'none');
h1.Title = 'LWA2 P1 Ch37 RSSI (dB)';
h1.XLabel = 'cm';
h1.YLabel = 'cm';
h1.FontSize = 16;
h1.ColorLimits = [-45 -30]; % Equivalente a caxis
s1 = struct(h1);
s1.XAxis.TickLabelRotation = 0;

% LWA2 #38 Port 1
subplot(2, 3, 2);
h2 = heatmap(valueX, valueY, flip(lwa2_P1_38), 'Colormap', colors_green, 'CellLabelColor', 'none');
h2.Title = 'LWA2 P1 Ch38 RSSI (dB)';
h2.XLabel = 'cm';
h2.YLabel = 'cm';
h2.FontSize = 16;
h2.ColorLimits = [-45 -30];
s2 = struct(h2);
s2.XAxis.TickLabelRotation = 0;

% LWA2 #39 Port 1
subplot(2, 3, 3);
h3 = heatmap(valueX, valueY, flip(lwa2_P1_39), 'Colormap', colors_blue, 'CellLabelColor', 'none');
h3.Title = 'LWA2 P1 Ch39 RSSI (dB)';
h3.XLabel = 'cm';
h3.YLabel = 'cm';
h3.FontSize = 16;
h3.ColorLimits = [-45 -30];
s3 = struct(h3);
s3.XAxis.TickLabelRotation = 0;

% LWA2 #37 Port 2
subplot(2, 3, 4);
h4 = heatmap(valueX, valueY, flip(lwa2_P2_37), 'Colormap', colors_red, 'CellLabelColor', 'none');
h4.Title = 'LWA2 P2 Ch37 RSSI (dB)';
h4.XLabel = 'cm';
h4.YLabel = 'cm';
h4.FontSize = 16;
h4.ColorLimits = [-45 -30];
s4 = struct(h4);
s4.XAxis.TickLabelRotation = 0;

% LWA2 #38 Port 2
subplot(2, 3, 5);
h5 = heatmap(valueX, valueY, flip(lwa2_P2_38), 'Colormap', colors_green, 'CellLabelColor', 'none');
h5.Title = 'LWA2 P2 Ch38 RSSI (dB)';
h5.XLabel = 'cm';
h5.YLabel = 'cm';
h5.FontSize = 16;
h5.ColorLimits = [-45 -30];
s5 = struct(h5);
s5.XAxis.TickLabelRotation = 0;

% LWA2 #39 Port 2
subplot(2, 3, 6);
h6 = heatmap(valueX, valueY, flip(lwa2_P2_39), 'Colormap', colors_blue, 'CellLabelColor', 'none');
h6.Title = 'LWA1 P2 Ch39 RSSI (dB)';
h6.XLabel = 'cm';
h6.YLabel = 'cm';
h6.FontSize = 16;
h6.ColorLimits = [-45 -30];
s6 = struct(h6);
s6.XAxis.TickLabelRotation = 0;


%% Plot the different SC RSSI level figures for Monopoles 1 and 3
figure;
set(gcf, 'color', 'w'); % Fondo blanco

% Monopole1 #37 
subplot(2, 3, 1);
h1 = heatmap(valueX, valueY, flip(monp1_37), 'Colormap', colors_red, 'CellLabelColor', 'none');
h1.Title = 'Monopole1 Ch37 RSSI (dB)';
h1.XLabel = 'cm';
h1.YLabel = 'cm';
h1.FontSize = 16;
h1.ColorLimits = [-50 -30]; % Equivalente a caxis
s1 = struct(h1);
s1.XAxis.TickLabelRotation = 0;

% Monopole1 #38 
subplot(2, 3, 2);
h2 = heatmap(valueX, valueY, flip(monp1_38), 'Colormap', colors_green, 'CellLabelColor', 'none');
h2.Title = 'Monopole1 Ch38 RSSI (dB)';
h2.XLabel = 'cm';
h2.YLabel = 'cm';
h2.FontSize = 16;
h2.ColorLimits = [-50 -30];
s2 = struct(h2);
s2.XAxis.TickLabelRotation = 0;

% Monopole1 #39 
subplot(2, 3, 3);
h3 = heatmap(valueX, valueY, flip(monp1_39), 'Colormap', colors_blue, 'CellLabelColor', 'none');
h3.Title = 'Monopole1 Ch39 RSSI (dB)';
h3.XLabel = 'cm';
h3.YLabel = 'cm';
h3.FontSize = 16;
h3.ColorLimits = [-50 -30];
s3 = struct(h3);
s3.XAxis.TickLabelRotation = 0;

% Monopole3 #37 
subplot(2, 3, 4);
h4 = heatmap(valueX, valueY, flip(monp3_37), 'Colormap', colors_red, 'CellLabelColor', 'none');
h4.Title = 'Monopole3 Ch37 RSSI (dB)';
h4.XLabel = 'cm';
h4.YLabel = 'cm';
h4.FontSize = 16;
h4.ColorLimits = [-50 -30];
s4 = struct(h4);
s4.XAxis.TickLabelRotation = 0;

% Monopole3 #38 Port 2
subplot(2, 3, 5);
h5 = heatmap(valueX, valueY, flip(monp3_38), 'Colormap', colors_green, 'CellLabelColor', 'none');
h5.Title = 'Monopole3 Ch38 RSSI (dB)';
h5.XLabel = 'cm';
h5.YLabel = 'cm';
h5.FontSize = 16;
h5.ColorLimits = [-50 -30];
s5 = struct(h5);
s5.XAxis.TickLabelRotation = 0;

% Monopole3 #39 Port 2
subplot(2, 3, 6);
h6 = heatmap(valueX, valueY, flip(monp3_39), 'Colormap', colors_blue, 'CellLabelColor', 'none');
h6.Title = 'Monopole3 Ch39 RSSI (dB)';
h6.XLabel = 'cm';
h6.YLabel = 'cm';
h6.FontSize = 16;
h6.ColorLimits = [-50 -30];
s6 = struct(h6);
s6.XAxis.TickLabelRotation = 0;

%% Plot the different SC RSSI level figures for Monopoles 2 and 4
figure;
set(gcf, 'color', 'w'); % Fondo blanco

% Monopole2 #37 
subplot(2, 3, 1);
h1 = heatmap(valueX, valueY, flip(monp2_37), 'Colormap', colors_red, 'CellLabelColor', 'none');
h1.Title = 'Monopole2 Ch37 RSSI (dB)';
h1.XLabel = 'cm';
h1.YLabel = 'cm';
h1.FontSize = 16;
h1.ColorLimits = [-50 -30]; % Equivalente a caxis
s1 = struct(h1);
s1.XAxis.TickLabelRotation = 0;

% Monopole2 #38 
subplot(2, 3, 2);
h2 = heatmap(valueX, valueY, flip(monp2_38), 'Colormap', colors_green, 'CellLabelColor', 'none');
h2.Title = 'Monopole2 Ch38 RSSI (dB)';
h2.XLabel = 'cm';
h2.YLabel = 'cm';
h2.FontSize = 16;
h2.ColorLimits = [-50 -30];
s2 = struct(h2);
s2.XAxis.TickLabelRotation = 0;

% Monopole2 #39 
subplot(2, 3, 3);
h3 = heatmap(valueX, valueY, flip(monp2_39), 'Colormap', colors_blue, 'CellLabelColor', 'none');
h3.Title = 'Monopole2 Ch39 RSSI (dB)';
h3.XLabel = 'cm';
h3.YLabel = 'cm';
h3.FontSize = 16;
h3.ColorLimits = [-50 -30];
s3 = struct(h3);
s3.XAxis.TickLabelRotation = 0;

% Monopole4 #37 
subplot(2, 3, 4);
h4 = heatmap(valueX, valueY, flip(monp4_37), 'Colormap', colors_red, 'CellLabelColor', 'none');
h4.Title = 'Monopole4 Ch37 RSSI (dB)';
h4.XLabel = 'cm';
h4.YLabel = 'cm';
h4.FontSize = 16;
h4.ColorLimits = [-50 -30];
s4 = struct(h4);
s4.XAxis.TickLabelRotation = 0;

% Monopole4 #38 Port 2
subplot(2, 3, 5);
h5 = heatmap(valueX, valueY, flip(monp4_38), 'Colormap', colors_green, 'CellLabelColor', 'none');
h5.Title = 'Monopole4 Ch38 RSSI (dB)';
h5.XLabel = 'cm';
h5.YLabel = 'cm';
h5.FontSize = 16;
h5.ColorLimits = [-50 -30];
s5 = struct(h5);
s5.XAxis.TickLabelRotation = 0;

% Monopole4 #39 Port 2
subplot(2, 3, 6);
h6 = heatmap(valueX, valueY, flip(monp4_39), 'Colormap', colors_blue, 'CellLabelColor', 'none');
h6.Title = 'Monopole4 Ch39 RSSI (dB)';
h6.XLabel = 'cm';
h6.YLabel = 'cm';
h6.FontSize = 16;
h6.ColorLimits = [-50 -30];
s6 = struct(h6);
s6.XAxis.TickLabelRotation = 0;


