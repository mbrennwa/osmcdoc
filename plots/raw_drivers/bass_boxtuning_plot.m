% load data (mic in box, nearfield)
BR100HP_inbox = load ('woofer_SPL_bass/inbox_BR100HP_8cm.mat'); % mic inbox measurement, BR100HP 8cm
BR100HP_woofer = load ('woofer_SPL_bass/nearfield_woofer_BR100HP_8cm.mat'); % woofer nearfield, with BR100HP 8cm

% load bafflestep simulation (Tolvan Edge for Faital 12PR320 in OSMC baffle
b = load ('../osmc_analysis/osmc_bafflestep_simulation_tolvan_edge.txt');
bstep.f = b(:,1); bstep.mag = b(:,4)-20*log10(2); clear b;


% determine SPL response vs. frequency
[BR100HP_inbox.mag,BR100HP_inbox.phase,BR100HP_inbox.f] = mataa_IR_to_FR(BR100HP_inbox.h/BR100HP_inbox.U0rms*2.83,BR100HP_inbox.t,[],BR100HP_inbox.unit);
[BR100HP_woofer.mag,BR100HP_woofer.phase,BR100HP_woofer.f] = mataa_IR_to_FR(BR100HP_woofer.h/BR100HP_woofer.U0rms*2.83,BR100HP_woofer.t,[],BR100HP_woofer.unit);

% convert mic-in-box measurements to free-field:
Vb = 70; r = 1;
BR100HP_inbox.mag = mataa_FR_inbox_convert (BR100HP_inbox.mag,BR100HP_inbox.f,Vb,r);

% merge deep bass and upper bass curves:
[BR100HP.mag,BR100HP.phase,BR100HP.f] = mataa_FR_extend_LF (BR100HP_woofer.f,BR100HP_woofer.mag,BR100HP_woofer.phase,BR100HP_inbox.f,BR100HP_inbox.mag,BR100HP_inbox.phase,90,110);
BR100HP.mag = BR100HP.mag - (BR100HP.mag(1)-BR100HP_inbox.mag(1));

% apply baffle step compensation (4pi):
BR100HP_bst = BR100HP;
BR100HP_bst.mag = BR100HP_bst.mag + interp1(bstep.f,bstep.mag,BR100HP_bst.f);

% determine group delay from free-field 2pi SPL response:
[m1,p1,f1] = mataa_FR_smooth (BR100HP.mag,0*BR100HP.mag,BR100HP.f,1/6); % smoothed SPL response
p1 = mataa_minimum_phase (m1,f1); % minimum phase (without excess phase trend due to "flight time")
F = logspace (log10(5),log10(500),1000);
P1 = interp1 (f1,p1,F);
dw = 2*pi*diff (F);
dP1 = pi/180*diff(P1);
gd1 = -dP1./dw; % group delay
fgd = F(1:end-1) + (F(2)-F(1))/2;

% plot results
subplot (2,1,1)
semilogx( BR100HP.f,BR100HP.mag,'k-' , BR100HP_bst.f,BR100HP_bst.mag,'k--' )
% title ("Monkey Coffin low-frequency SPL\n (2.83 Vrms, 1 m, 2\\pi, no x-over)")
% xlabel ('Frequency (Hz)')
ylabel ('SPL (dB-SPL)')
grid on
axis([25 330 80 100])
xt = [10 30 50 100 300 1000]; xts = {'10' , '30' , '50' , '100' , '300' , '500' , '1000'};
set(gca,'xtick',xt)
set(gca,'xticklabel',xts)

subplot (2,1,2)
semilogx( fgd,gd1*1000,'k-')
xlabel ('Frequency (Hz)')
ylabel ('Group delay (ms)')
grid on
axis([25 330 0 30])
xt = [10 30 50 100 300 1000]; xts = {'10' , '30' , '50' , '100' , '300' , '500' , '1000'};
set(gca,'xtick',xt)
set(gca,'xticklabel',xts)

W = 8; H = W; set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[W,H],'PaperPosition',[0,0,W,H]); print ('OSMC_bass_tuning.eps','-depsc2')
