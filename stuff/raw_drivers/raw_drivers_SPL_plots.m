clear all
close all
width = 6; height = 12;

ax = [100 20e3 50 110];

ci = 'r-'; % color for "inside" angles
co = 'b-'; % color for "outside" angles
c0 = 'k-'; % color for "on axis"

h = figure (1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot woofer SPL response curves %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[f0,mag0]   = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_12PR320_1m_hor_0.frd" );
[f15,mag15] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_12PR320_1m_hor_+15.frd" );
[f30,mag30] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_12PR320_1m_hor_+30.frd" );
[f45,mag45] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_12PR320_1m_hor_+45.frd" );
[f60,mag60] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_12PR320_1m_hor_+60.frd" );
[f75,mag75] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_12PR320_1m_hor_+75.frd" );
[f90,mag90] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_12PR320_1m_hor_+90.frd" );


subplot (3,1,1);
semilogx ( f0,mag0,c0 , f15,mag15,c0 , f30,mag30,c0 , f45,mag45,c0 , f60,mag60,c0 , f75,mag75,c0 , f90,mag90,c0 )
axis (ax)
% xlabel ('Frequency (Hz)')
ylabel ('SPL (dB-SPL)')
grid on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot midrange SPL response curves %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[f0,mag0]   = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_0.frd" );
[f15i,mag15i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_+15.frd" );
[f30i,mag30i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_+30.frd" );
[f45i,mag45i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_+45.frd" );
[f60i,mag60i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_+60.frd" );
[f75i,mag75i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_+75.frd" );
[f90i,mag90i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_+90.frd" );
[f15o,mag15o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_-15.frd" );
[f30o,mag30o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_-30.frd" );
[f45o,mag45o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_-45.frd" );
[f60o,mag60o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_-60.frd" );
[f75o,mag75o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_-75.frd" );
[f90o,mag90o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_VM752_1m_hor_-90.frd" );

subplot (3,1,2)
semilogx ( 	f0,mag0,c0 , ...
		f15i,mag15i,ci , f30i,mag30i,ci , f45i,mag45i,ci , f60i,mag60i,ci , f75i,mag75i,ci , f90i,mag90i,ci , ...
		f15o,mag15o,co , f30o,mag30o,co , f45o,mag45o,co , f60o,mag60o,co , f75o,mag75o,co , f90o,mag90o,co )
axis (ax)
% xlabel ('Frequency (Hz)')
ylabel ('SPL (dB-SPL)')
grid on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot tweeter SPL response curves %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[f0,mag0]     = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_0.frd" );
[f15i,mag15i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_+15.frd" );
[f30i,mag30i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_+30.frd" );
[f45i,mag45i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_+45.frd" );
[f60i,mag60i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_+60.frd" );
[f75i,mag75i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_+75.frd" );
[f90i,mag90i] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_+90.frd" );
[f15o,mag15o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_-15.frd" );
[f30o,mag30o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_-30.frd" );
[f45o,mag45o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_-45.frd" );
[f60o,mag60o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_-60.frd" );
[f75o,mag75o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_-75.frd" );
[f90o,mag90o] = mataa_import_FRD ( "spliced_curves/MonkeyCoffin20181229_SCANR2904WG148_1m_hor_-90.frd" );

subplot(3,1,3)
semilogx ( 	f0,mag0,c0 , ...
		f15i,mag15i,ci , f30i,mag30i,ci , f45i,mag45i,ci , f60i,mag60i,ci , f75i,mag75i,ci , f90i,mag90i,ci , ...
		f15o,mag15o,co , f30o,mag30o,co , f45o,mag45o,co , f60o,mag60o,co , f75o,mag75o,co , f90o,mag90o,co )
axis (ax)
xlabel ('Frequency (Hz)')
ylabel ('SPL (dB-SPL)')
grid on

for k = 1:3
	subplot(3,1,k)
	sub_pos = get(gca,'position'); % get subplot axis position
	set(gca,'position',sub_pos.*[1 1 1.0 1.43]-[0 0.03 0 0]) % stretch its width and height 
end

set(h,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height])
print ('SPL_curves_raw.eps','-depsc2')
