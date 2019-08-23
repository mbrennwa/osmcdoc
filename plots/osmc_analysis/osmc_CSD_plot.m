% script to plot the OSMC CSD diagram

graphics_toolkit ('fltk'); % gnuplot can't do nice CSDs

% load raw data:
x = load ('data_onaxis/full_system.mat');

% crop anechoic data
[h,t] = mataa_signal_crop (x.h,x.t,0.0028,0.00643);

% calculate and plot CSD data
T = [0:1E-4:4E-3];
[spl,f,d] = mataa_IR_to_CSD (h,t,T,1/24);

k = find (f <= 20e3);
mataa_plot_CSDt (spl(k),f(k),d(k),25);
set(gca,'linewidth',3)

width = 8; height = 4; set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_CSD_diagram.eps','-depsc2')
