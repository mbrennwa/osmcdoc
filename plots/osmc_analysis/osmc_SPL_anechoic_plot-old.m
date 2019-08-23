% script to plot the OSMC SPL response (on-axis response 1m)
% anechoic part merged to in-room response by extending the length of the IR beyond the anechoic part
% NOTE: woofer near-field response shows sloping trend, which is caused by the baffle-step compensation built into the x-over --> near-field response is not suitable for splicing to far-field response in order to extend anechoic frequency response towards low frequencies

graphics_toolkit ('gnuplot'); % use gnuplot backend

% load raw data (farfield):
summed   = load ('data_onaxis/full_system.mat');
woofer   = load ('data_onaxis/woofer.mat');
midrange = load ('data_onaxis/midrange.mat');
tweeter  = load ('data_onaxis/tweeter.mat');

% load raw data (nearfield):
woofer_nf = load ('data_onaxis/woofer_nearfield.mat');
port_nf = load ('data_onaxis/BRport_nearfield.mat');
inbox_nf = load ('data_onaxis/inbox.mat');

% normalise to 2.83 Vrms input:
summed.h   = summed.h / summed.U0rms * sqrt(8);
woofer.h   = woofer.h / woofer.U0rms * sqrt(8);
midrange.h = midrange.h / midrange.U0rms * sqrt(8);
tweeter.h  = tweeter.h / tweeter.U0rms * sqrt(8);
woofer_nf.h   = woofer_nf.h / woofer_nf.U0rms * sqrt(8);
port_nf.h   = port_nf.h / port_nf.U0rms * sqrt(8);
inbox_nf.h   = inbox_nf.h / inbox_nf.U0rms * sqrt(8);

h_unit = summed.unit;

% calculate farfield SPL response curves (with low-frequency extension using echoic part of IR):
t1 = 0.0029; % start of impulse response
t2 = 0.00643; % start of anechoic part
t3 = t1+0.04; % end of echoic part
N = 20; % number of frequency-response values to calculate in echoic frequency range
res = 1/12;
fc = 1/(t2-t1); % cut-off frequency of anechoic part
[summed.mag,summed.phase,summed.f]       = mataa_IR_to_FR_LFextend (summed.h,summed.t,t1,t2,t3,N,res,'Pa');
[woofer.mag,woofer.phase,woofer.f]       = mataa_IR_to_FR_LFextend (woofer.h,woofer.t,t1,t2,t3,N,res,'Pa');
[midrange.mag,midrange.phase,midrange.f] = mataa_IR_to_FR_LFextend (midrange.h,midrange.t,t1,t2,t3,N,res,'Pa');
[tweeter.mag,tweeter.phase,tweeter.f]    = mataa_IR_to_FR_LFextend (tweeter.h,tweeter.t,t1,t2,t3,N,res,'Pa');

% calculate nearfield SPL curves:
res = 1/12;
[woofer_nf.mag,woofer_nf.phase,woofer_nf.f] = mataa_IR_to_FR (woofer_nf.h,woofer_nf.t,res,'Pa');
[port_nf.mag,port_nf.phase,port_nf.f] = mataa_IR_to_FR (port_nf.h,port_nf.t,res,'Pa');
[inbox_nf.mag,inbox_nf.phase,inbox_nf.f] = mataa_IR_to_FR (inbox_nf.h,inbox_nf.t,res,'Pa');
inbox_nf.mag = inbox_nf.mag - 40*log10(inbox_nf.f/inbox_nf.fL); % see https://www.audioxpress.com/article/measuring-loudspeaker-low-frequency-response

% anechoic bass data:
k = find(summed.f <= fc);
summed_bass.f = summed.f(k);
summed_bass.mag = summed.mag(k);
k = find(woofer.f <= fc);
woofer_bass.f = woofer.f(k);
woofer_bass.mag = woofer.mag(k);

% remove crap data:
tweeter.mag(find(tweeter.f < 1000)) = NA;	
midrange.mag(find(midrange.f < fc)) = NA;
midrange.mag(find(midrange.f > 5200)) = NA;
woofer.mag(find(woofer.f > 580)) = NA;
woofer.mag(find(woofer.f < fc)) = NA;
summed.mag(find(summed.f < fc)) = NA;
woofer_nf.mag(find(woofer_nf.f > 545)) = NA;
woofer_nf.mag(find(woofer_nf.f < woofer_nf.fL)) = NA;

% plot farfield response curves:
figure(1)
semilogx(woofer.f,woofer.mag,'r-','linewidth',3); hold on
semilogx(midrange.f,midrange.mag,'g-','linewidth',3);
semilogx(tweeter.f,tweeter.mag,'b-','linewidth',3);
semilogx(summed.f,summed.mag,'k-','linewidth',3);
semilogx(woofer_bass.f,woofer_bass.mag,'color',[1 0.6 0.6],'linewidth',3);
semilogx(summed_bass.f,summed_bass.mag,'color',0.6*[1 1 1],'linewidth',3);

semilogx([fc fc],[0 fc],'k--');
hold off

axis ([25 20e3 60 100]);
set(gca,'linewidth',3)
xlabel ('Frequency (Hz)');
ylabel ('SPL @ 2.83 V_{rms} (dB-SPL)');

% plot nearfield response curves:
figure(2)
semilogx(woofer_nf.f,woofer_nf.mag,'r-','linewidth',3); hold on
% semilogx(inbox_nf.f,inbox_nf.mag-10,'b-','linewidth',2);

slope = 3;
ff = [80 300];
SL = 139 - 3*log2(ff); % slope of xx dB per octave
semilogx(ff,SL,'k--','linewidth',2);

hold off

axis([25 700 80 125])
set (gca,'ytick',[0:10:200]);
xt = [10 25 50 75 100 250 500 750 1000];
set (gca,'xtick',xt);
xt = strtrim(cellstr(num2str(xt(:))));
set (gca,'xticklabel',xt);
set(gca,'linewidth',3)

xlabel ('Frequency (Hz)');
ylabel ('SPL @ 2.83 V_{rms} (dB-SPL)');



% grid on

figure(1); width = 8; height = 4; set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_SPL_response_farfield.eps','-depsc2')
figure(2); width = 8; height = 4; set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_SPL_response_woofer_nearfield.eps','-depsc2')
