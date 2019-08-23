% script to plot the OSMC SPL response (nearfield, woofer with xover)

graphics_toolkit ('gnuplot'); % use gnuplot backend

% load raw data (nearfield):
woofer_nf = load ('data_onaxis/woofer_nearfield.mat');
port_nf = load ('data_onaxis/BRport_nearfield.mat');
inbox = load ('data_onaxis/inbox.mat');

% load bafflestep simulation (Tolvan Edge for Faital 12PR320 in OSMC baffle
bafflestep = load ('osmc_bafflestep_simulation_tolvan_edge.txt');

% normalise to 2.83 Vrms input:
woofer_nf.h   = woofer_nf.h / woofer_nf.U0rms * sqrt(8);
port_nf.h     = port_nf.h / port_nf.U0rms * sqrt(8);
inbox.h       = inbox.h / inbox.U0rms * sqrt(8);

% calculate nearfield SPL curves:
res = 1/12;
[woofer_nf.mag,woofer_nf.phase,woofer_nf.f] = mataa_IR_to_FR (woofer_nf.h,woofer_nf.t,res,'Pa');
[port_nf.mag,port_nf.phase,port_nf.f] = mataa_IR_to_FR (port_nf.h,port_nf.t,res,'Pa');
[inbox.mag,inbox.phase,inbox.f] = mataa_IR_to_FR (inbox.h,inbox.t,res,'Pa');

inbox.mag = inbox.mag + 40*log10(inbox.f/100) + 6.8;

% remove crap data:
woofer_nf.mag(find(woofer_nf.f > 545)) = NA;
woofer_nf.mag(find(woofer_nf.f < woofer_nf.fL)) = NA;

% k = find (bafflestep(:,1) <= 500); bafflestep = bafflestep(k,:);

% plot nearfield response curve:
figure(1)
semilogx(woofer_nf.f,woofer_nf.mag,'r-','linewidth',3); hold on
% semilogx(port_nf.f,port_nf.mag,'b-','linewidth',3);
semilogx(inbox.f,inbox.mag-10,'b-','linewidth',2);

% slope = 3;
% ff = [80 300];
% SL = 139 - 3*log2(ff); % slope of xx dB per octave
% semilogx(ff,SL,'k--','linewidth',2);

semilogx (bafflestep(:,1),122-bafflestep(:,4),'k--','linewidth',2)

hold off

axis([20 500 90 125])
xt = [10:10:100]; xt = unique ([ xt 10*xt]);
% xt = [10 25 50 75 100 250 500 750 1000];
% xt = [30 50 100 300 500];
set (gca,'xtick',xt);

xt = strtrim(cellstr(num2str(xt(:))));
set (gca,'xticklabel',xt);

set(gca,'linewidth',3)

xlabel ('Frequency (Hz)');
ylabel ('SPL @ 2.83 V_{rms} (dB-SPL)');

figure(1); width = 8; height = 4; set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_SPL_response_woofer_nearfield.eps','-depsc2')
