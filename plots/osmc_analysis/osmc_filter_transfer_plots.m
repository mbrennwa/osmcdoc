% script to plot the OSMC filter transfer curves

graphics_toolkit ('fltk'); % use fltk backend

% load raw data (IR):
woofer   = load ('data_filter_transfer_EL20190303/woofer_20190303.mat');
midrange = load ('data_filter_transfer_EL20190303/midrange_20190303.mat');
tweeter  = load ('data_filter_transfer_EL20190303/tweeter_20190303.mat');


% normalise to 1.0 Vrms input:
woofer.h   = woofer.h / woofer.U0rms;
midrange.h = midrange.h / midrange.U0rms;
tweeter.h  = tweeter.h / tweeter.U0rms;

h_unit = woofer.unit;

% calculate transfer functions:
[woofer.mag,woofer.phase,woofer.f,mag_unit] = mataa_IR_to_FR (woofer.h,woofer.t,1/12,'V');
[midrange.mag,womidrangeofer.phase,midrange.f] = mataa_IR_to_FR (midrange.h,midrange.t,1/12,'V');
[tweeter.mag,tweeter.phase,tweeter.f] = mataa_IR_to_FR (tweeter.h,tweeter.t,1/12,'V');

% reduce data points to a sane number:
ff = logspace(0,log10(20E3),1000);
woofer.mag   = interp1 (woofer.f,woofer.mag,ff);     woofer.f = ff;
midrange.mag = interp1 (midrange.f,midrange.mag,ff); midrange.f = ff;
tweeter.mag  = interp1 (tweeter.f,tweeter.mag,ff);   tweeter.f = ff;

% plot magnitude response curves:
figure(1)
semilogx(woofer.f,woofer.mag,'b-','linewidth',3 , midrange.f,midrange.mag,'k-','linewidth',3 , tweeter.f,tweeter.mag,'r-','linewidth',3);

axis ([20 20e3 -40 10]);
set(gca,'linewidth',3)
xlabel ('Frequency (Hz)');
ylabel ('Gain (dB)');

%% grid on

% figure(1); width = 8; height = 5; set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_filter_transfer.eps','-depsc2')

