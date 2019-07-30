% script to plot the OSMC step response (on-axis response 1m)

graphics_toolkit ('gnuplot'); % use gnuplot backend

x = load ('data_onaxis/full_system.mat');

x.h = x.h / x.U0rms * sqrt(8);

k = find (x.t > 0.00290 & x.t < 0.0024+0.01);

[s,t] = mataa_IR_to_SR (x.h(k),x.t(k));

plot (1000*(t-t(1)),s*1E6,'k-','linewidth',2);
axis ([-0.3 3.55 -1.3 2.2]);
set (gca,'xtick',[0:1:10],'ytick',[-2:1:5])

xlabel ('Time (ms)');
ylabel ('Pressure (\muPa)')

width = 8; height = 4; set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_step_response.eps','-depsc2')
