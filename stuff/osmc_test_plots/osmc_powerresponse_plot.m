% script to plot the power response of the OSMC box (full system with EL0303 xover, Scan R2904 in circular augerpro waveguide)

graphics_toolkit ('gnuplot'); % use gnuplot backend

load 'data_dispersion/power_response.mat';

slope = 1.9;
SL = 111.5 - slope*log2((f)); % slope of xx dB per octave
disp (sprintf('Slope = %g per octave',slope))

semilogx (f,PR,'k-','linewidth',2 , f,SL,'k--','linewidth',1 );
axis ([300 30000 70 100])
% title ('Power response')
xlabel ('Frequency (Hz)')
ylabel ('Power response (dB-SPL)')
set (gca,'ytick',[50:10:150]);

width = 8; height = 3.5; set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_powerresponse.eps','-depsc2');
