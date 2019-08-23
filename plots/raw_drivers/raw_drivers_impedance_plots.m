clear all
close all
width = 6; height = 8;

ax = [10 20e3 1 200];

cw = 'b';
cm = 'k';
ct = 'r';

h = figure (1);

%%%%%%%%%%%%%%%%%%%%%%%%%
% plot impedance curves %
%%%%%%%%%%%%%%%%%%%%%%%%%

[W.f,W.Zm,W.Zp] = mataa_import_FRD ("impedance/WOOFER_IMPEDANCE_rear_port_141mm.TXT");
[M.f,M.Zm,M.Zp] = mataa_import_FRD ("impedance/Volt_VM752_driver-A_impedance.frd");
[T.f,T.Zm,T.Zp] = mataa_import_FRD ("impedance/ScanR2904+WG148 MonkeyBox Impedance.txt");

subplot(2,1,1)
loglog ( 	W.f,W.Zm,[cw '-'] , ...
		M.f,M.Zm,[cm '-'] , ...
		T.f,T.Zm,[ct '-']  ...
	)
axis (ax)
ylabel ('Magnitude (Ohm)')
grid on
l = legend ('Woofer','Midrange','Tweeter');

subplot(2,1,2)
semilogx ( 	W.f,W.Zp,[cw '-'] , ...
		M.f,M.Zp,[cm '-'] , ...
		T.f,T.Zp,[ct '-']  ...
	)
set(gca,'ytick',[-90:45:90])
axis ([ax(1) ax(2) -90 90])
xlabel ('Frequency (Hz)')
ylabel ('Phase (degrees)')
grid on

for k = 1:2
	subplot(2,1,k)
	sub_pos = get(gca,'position'); % get subplot axis position
	set(gca,'position',sub_pos.*[1 1 1 1.3	]-[0 0.03 0 0]) % stretch its width and height 
end

set(h,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height])
set(l,'position',[0.65 0.885 0.24 0.09]);
print ('impedance_curves_drivers.eps','-depsc2')





