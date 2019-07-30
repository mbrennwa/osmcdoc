% script to plot the dispersion of the OSMC box (full system with EL0303 xover, Scan R2904 in circular augerpro waveguide)

1; 

% process and plot data:
function [mag,phase,f,a] = __dispersion_proc(x,ang)
	t0 = 0.0027;
	t1 = 0.00291+0.0034;
	res = 1/24;
	M = P = F = [];
	for i = 1:length(x)
		k = find (x{i}.t >= t0 & x{i}.t <= t1);
		t = x{i}.t(k); h = x{i}.h(k);
		h = h*sqrt(8)/x{i}.U0rms;
		[mag,phase,f,unit_mag] = mataa_IR_to_FR(h,t,res,x{i}.unit);
		M = [ M ; mag ];
		P = [ P ; phase ];
		F = [ F ; f ];
	end

	f = unique(F(:));
	N = size(M,1);
	mag = phase = repmat(NA,N,length(f));
	for i=1:N
		mag(i,:)   = interp1 (F(i,:),M(i,:),f);
		phase(i,:) = interp1 (F(i,:),P(i,:),f);
	end
	[a,k] = sort(ang);
	mag   = mag(k,:);
	phase = phase(k,:);
end

% fix x-tick labels:
function __fix_x_ticklabels()
	x = get (gca,'xtick');
	u = get (gca,'xticklabel');
	for i = 1:length(x)
		if x(i) >= 1000
			u{i} = [ num2str(x(i)/1000) 'k' ];
		else
			u{i} = num2str(x(i));
		end
	end
	set (gca,'xticklabel',u)
end



deg = -180:10:180;

% load data:
function x = __load_dispersion_data(f)
end

f_hor = { 'data_dispersion/OSMC_acoustic_hor_inside_10.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_20.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_30.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_40.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_50.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_60.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_70.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_80.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_90.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_100.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_110.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_120.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_130.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_140.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_150.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_160.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_170.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_180.mat' , 'data_dispersion/OSMC_acoustic_hor_onaxis_0.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_10.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_20.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_30.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_40.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_50.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_60.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_70.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_80.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_90.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_100.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_110.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_120.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_130.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_140.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_150.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_160.mat' , 'data_dispersion/OSMC_acoustic_hor_outside_170.mat' , 'data_dispersion/OSMC_acoustic_hor_inside_180.mat' };

f_ver = {'data_dispersion/OSMC_acoustic_ver_upwards_180.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_170.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_160.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_150.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_140.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_130.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_120.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_110.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_100.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_90.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_80.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_70.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_60.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_50.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_40.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_30.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_20.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_10.mat' , 'data_dispersion/OSMC_acoustic_ver_onaxis_0.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_10.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_20.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_30.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_40.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_50.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_60.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_70.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_80.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_90.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_100.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_110.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_120.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_130.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_140.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_150.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_160.mat' , 'data_dispersion/OSMC_acoustic_ver_downwards_170.mat' , 'data_dispersion/OSMC_acoustic_ver_upwards_180.mat' };

ang_hor = [ 10:10:180 0:-10:-180 ]; % positive angles <==> "inside"
ang_ver = [ 180:-10:-180 ]; % positive angles <==> "upwards"

x_hor = x_ver = {};
for i = 1:length(f_hor)
	x_hor{i} = load (f_hor{i});
end
for i = 1:length(f_ver)
	x_ver{i} = load (f_ver{i});
end

% calculate SPL response data:
[mh,ph,fh,ah] = __dispersion_proc(x_hor,ang_hor);
[mv,pv,fv,av] = __dispersion_proc(x_ver,ang_ver);

% export data to ASCII files
% for i=1:length(ah)
% 	mataa_export_FRD (fh,mh(i,:),ph(i,:),'',sprintf('FRD_data_dispersion/osmc hor %i.txt',ah(i)));
% end
% for i=1:length(av)
% 	mataa_export_FRD (fv,mv(i,:),pv(i,:),'',sprintf('FRD_data_dispersion/osmc ver %i.txt',ah(i)));
% end

% plot polar diagrams:
mh = mh - max(max(mh));
mv = mv - max(max(mv));

levels = [-30:1:0];
k = find(mh < min(levels));
mh(k) = min(levels);
k = find(mv < min(levels));
mv(k) = min(levels);
clear k

fx = [10 30 100 300 1000 3000 10000 30000];

graphics_toolkit ('gnuplot'); % the FLTK backend can't save the plots to a file

figure(1)
h = contourf(fh,ah,mh,levels);
set (gca,'xscale','log','xtick',fx,'ytick',[-180:90:180])
axis ([300 30000 -180 180])
colormap(flipud(colormap('rainbow')))
% title ('Horizontal dispersion')
xlabel ('Frequency (Hz)')
ylabel ('Horizontal angle (deg.)')
__fix_x_ticklabels()

h = colorbar ('EastOutside');
t = get(h,'yticklabel');
for i = 1:length(t);
	t{i} = sprintf('%s dB',t{i});
end
set (h,'yticklabel',t);



figure(2)
h = contourf(fv,av,mv,levels);
set (gca,'xscale','log','xtick',fx,'ytick',[-180:90:180])
axis ([300 30000 -180 180])
colormap(flipud(colormap('rainbow')))
% title ('Vertical dispersion')
xlabel ('Frequency (Hz)')
ylabel ('Vertical angle (deg.)')
__fix_x_ticklabels()

h = colorbar ('EastOutside');
t = get(h,'yticklabel');
for i = 1:length(t);
	t{i} = sprintf('%s dB',t{i});
end
set (h,'yticklabel',t);


width = 8; height = 5; figure(1); set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_ploar_horizontal.eps','-depsc2'); figure(2); set(gcf,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height]); print ('osmc_polar_vertical.eps','-depsc2')
