% script to plot the OSMC SPL response (on-axis free-field / 4pi response 1m)
% anechoic, extended with woofer measurements taken using in-box technique
%
% free-field bass response was determined as follows:
% 1. Use in-box measurement to determine 2pi woofer response (without xover)
% 2. Convert 2pi woofer response to 4pi response by applying baffle step (from Tolvan edge simulation)
% 3. Apply woofer xover filter transfer to determine 4pi system response at bass frequencies (well below woofer/mid transition)

% graphics_toolkit ('gnuplot'); % use gnuplot backend
graphics_toolkit ('fltk'); % use fltk backend

% load woofer data:
%%% woofer_outdoor   = load ('data_outdoor/outdoor_20181228/12pr320_1m_onaxis_nochair_portstuffed_1.mat');
woofer_filter    = load ('data_filter_transfer_EL20190303/woofer_20190303.mat');
woofer_inbox = load ('../raw_drivers/woofer_SPL_bass/inbox_BR100HP_8cm.mat'); % mic inbox measurement, BR100HP 8cm
woofer_nearfield = load ('../raw_drivers/woofer_SPL_bass/nearfield_woofer_BR100HP_8cm.mat'); % woofer nearfield, with

% load bafflestep simulation (Tolvan Edge for Faital 12PR320 in OSMC baffle
b = load ('osmc_bafflestep_simulation_tolvan_edge.txt');
bstep.f = b(:,1); bstep.mag = b(:,4)-20*log10(2); clear b;

% load farfield data:
anechoic   = load ('data_onaxis/full_system.mat'); % anechoic SPL response

% reduce echoes:
a = 0.5;
anechoic.h = a*anechoic.h + (1-a)*mataa_IR_remove_echo (anechoic.h,anechoic.t,0.00642,0.00676);

% normalise to 2.83 Vrms input:
anechoic.h   = anechoic.h / anechoic.U0rms * sqrt(8);
%%% woofer_outdoor.h   = woofer_outdoor.h / woofer_outdoor.U0rms * sqrt(8);
woofer_inbox.h = woofer_inbox.h / woofer_inbox.U0rms * sqrt(8);
woofer_nearfield.h = woofer_nearfield.h / woofer_nearfield.U0rms * sqrt(8);

% normalise to 1.0 Vrms input:
woofer_filter.h   = woofer_filter.h / woofer_filter.U0rms;

% crop anechoic part of impulse response:
t_start = 0.0029; % start of impulse response
t_end = 0.00643; % end of anechoic part
t_end = t_start + 1/250;
fc = 1 / (t_end-t_start);

[anechoic.h,anechoic.t] = mataa_signal_crop (anechoic.h,anechoic.t,t_start,t_end);

% calculate SPL curve(s):
res = 1/12;
[anechoic.mag,anechoic.anechoic,anechoic.f] = mataa_IR_to_FR (anechoic.h,anechoic.t,res,'Pa');

res = 1/4;
[woofer_filter.mag,woofer_filter.phase,woofer_filter.f,mag_unit] = mataa_IR_to_FR (woofer_filter.h,woofer_filter.t,res,'V');
%%% [woofer_outdoor.mag,woofer_outdoor.woofer_outdoor,woofer_outdoor.f] = mataa_IR_to_FR (woofer_outdoor.h,woofer_outdoor.t,res,'Pa');
%%% woofer_outdoor.mag = woofer_outdoor.mag + interp1 (woofer_filter.f,woofer_filter.mag,woofer_outdoor.f);
[woofer_inbox.mag,woofer_inbox.phase,woofer_inbox.f] = mataa_IR_to_FR(woofer_inbox.h,woofer_inbox.t,res,woofer_inbox.unit);
[woofer_nearfield.mag,woofer_nearfield.phase,woofer_nearfield.f] = mataa_IR_to_FR(woofer_nearfield.h,woofer_nearfield.t,res,woofer_nearfield.unit);

% convert mic-in-box measurements to free-field:
Vb = 70; r = 1;
woofer_inbox.mag = mataa_FR_inbox_convert (woofer_inbox.mag,woofer_inbox.f,Vb,r);

% merge deep bass (inbox) and upper bass (woofer nearfield) curves:
[bass.mag,bass.phase,bass.f] = mataa_FR_extend_LF (woofer_nearfield.f,woofer_nearfield.mag,woofer_nearfield.phase,woofer_inbox.f,woofer_inbox.mag,woofer_inbox.phase,90,110);
bass.mag = bass.mag - (bass.mag(1)-woofer_inbox.mag(1));

% apply baffle step (convert from nearfield / 2pi to farfield / 4pi):
bass.mag = bass.mag + interp1(bstep.f,bstep.mag,bass.f);

% apply woofer xover transfer:
bass.mag = bass.mag + interp1 (woofer_filter.f,woofer_filter.mag,bass.f);

% merge bass and anechoic measurements:
k = find (bass.f < 130);
spl.f = [ bass.f(k)' anechoic.f ];
spl.mag = [ bass.mag(k)' anechoic.mag+0.8 ]; % offset as mentioned here: https://www.diyaudio.com/forums/multi-way/327594-source-monkey-box-post5645789.html

% plot farfield response curves:
figure(1)
semilogx(spl.f,spl.mag,'k-','linewidth',1.3);

% axis ([25 20e3 60 100]);
axis ([50 20e3 60 100]);
%% set(gca,'linewidth',3)
grid on
xlabel ('Frequency (Hz)');
ylabel ('SPL @ 2.83 V_{rms} (dB-SPL)');

%% title ('OSMC SPL response (on-axis, 4pi, 1 m)')

figure(1); width = 8; height = 5;
set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_SPL_response.eps','-depsc2')
