% script to plot the OSMC SPL response (on-axis response 1m)
% anechoic

graphics_toolkit ('gnuplot'); % use gnuplot backend

% load raw data (farfield):
summed   = load ('data_onaxis/full_system.mat');
woofer   = load ('data_onaxis/woofer.mat');
midrange = load ('data_onaxis/midrange.mat');
tweeter  = load ('data_onaxis/tweeter.mat');

% normalise to 2.83 Vrms input:
summed.h   = summed.h / summed.U0rms * sqrt(8);
woofer.h   = woofer.h / woofer.U0rms * sqrt(8);
midrange.h = midrange.h / midrange.U0rms * sqrt(8);
tweeter.h  = tweeter.h / tweeter.U0rms * sqrt(8);

% calculate farfield SPL response curves:
t_start = 0.0029; % start of impulse response
t_end = 0.00643; % start of anechoic part
fc = 1 / (t_end-t_start);

[summed.h,summed.t] = mataa_signal_crop (summed.h,summed.t,t_start,t_end);
[woofer.h,woofer.t] = mataa_signal_crop (woofer.h,woofer.t,t_start,t_end);
[midrange.h,midrange.t] = mataa_signal_crop (midrange.h,midrange.t,t_start,t_end);
[tweeter.h,tweeter.t] = mataa_signal_crop (tweeter.h,tweeter.t,t_start,t_end);

res = 1/12;
[summed.mag,summed.summed,summed.f] = mataa_IR_to_FR (summed.h,summed.t,res,'Pa');
[woofer.mag,woofer.phase,woofer.f] = mataa_IR_to_FR (woofer.h,woofer.t,res,'Pa');
[midrange.mag,midrange.phase,midrange.f] = mataa_IR_to_FR (midrange.h,midrange.t,res,'Pa');
[tweeter.mag,tweeter.phase,tweeter.f] = mataa_IR_to_FR (tweeter.h,tweeter.t,res,'Pa');

% plot farfield response curves:
figure(1)
semilogx(woofer.f,woofer.mag,'r-','linewidth',3); hold on
semilogx(midrange.f,midrange.mag,'g-','linewidth',3);
semilogx(tweeter.f,tweeter.mag,'b-','linewidth',3);
semilogx(summed.f,summed.mag,'k-','linewidth',3);

semilogx([fc fc],[0 fc],'k--');
hold off

% axis ([25 20e3 60 100]);
axis ([fc 20e3 60 100]);
set(gca,'linewidth',3)
xlabel ('Frequency (Hz)');
ylabel ('SPL @ 2.83 V_{rms} (dB-SPL)');

figure(1); width = 8; height = 4; set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_SPL_response_farfield.eps','-depsc2')
