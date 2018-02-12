%% Copyright (C) 2012-2013 Roberto Ripio
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the Free Software
%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%
%% This function is part of DSD

function RRxof(fileshort, strGSFs, strCFClass)

home; close;
t1=time;

disp("RRxof\nRR Loudspeaker Crossover and Equalizer designer\n\
(C) 2012 Roberto Ripio\n");

disp(["Running from " fileparts(cmdpath=mfilename("fullpath")) "\n"]);
configDefaults= [cmdpath ".ini"];
if exist(configDefaults, "file")
    source(configDefaults);         % Reads default config
end

filename = [fileshort '.xof'];
source(filename);        			% Reads project config

% admits Fs as a parameter
if exist("strGSFs")
	GSFs=str2num(strGSFs);
else strGSFs = num2str(GSFs);
end

% admits CFClass as a parameter
if exist("strCFClass")
	CFClass = strCFClass;
end

% Establece el directorio y prefijo de salida 
[dummyFSOutDir , FSOutPrefix] = fileparts(FSInputFile); % values from frd file
[FSOutDir , dummyFSOutPrefix] = fileparts(filename); % values from input file
if length(FSOutDir)==0
	FSOutDir = ".";
end
FSOutDir = [FSOutDir "/" strGSFs "/"];
mkdir(FSOutDir);

FSOutPrefix = [CFClass "-" FSOutPrefix];

% Some advertizing on screen
GSFs
FSOutPrefix
disp ("\n");
% MS Message Settings
MSOk = "OK\n";						% End of routine confirmation

% ---------------------------------------------------------------------------------

c0=343; %speed of sound
pi2=2*pi;

% m, fft computation length
% We make equal length speaker correction filters and linear crossovers
% (half of final length)
m=2^GSLExp; m2=m/2; % Final filter length
m_ls=m/2; m2_ls=m2/2; % Speaker correction length

%%% Loudspeaker frequency response inversion %%%
% Reads magnitude response from .frd file
LSdB = frdinterp(FSInputFile,m_ls,GSFs);

ml_ls=GSFs/m_ls;	% low freq, freq jump
mh_ls=m2_ls*ml_ls;	% max freq

% Calculates transition limits
if CFLowF(1)==0
    TWLowF2=TWLimitLowF2;
else
	TWLowF2=CFLowF(1)/(2^TWFlatInterval);
	if TWLowF2<TWLimitLowF2 TWLowF2=TWLimitLowF2; end;
end
TWLowF1=TWLowF2/(2^TWTransitionInterval);
if TWLowF1<TWLimitLowF1 TWLowF1=TWLimitLowF1; end;
TWLowK2=round(TWLowF2/ml_ls)+1;
TWLowK1=round(TWLowF1/ml_ls)+1;
if TWLowK1<2 TWLowK1=2; end;
if TWLowK2<3 TWLowK2=3; end;

if CFHighF==0
    TWHighF1=TWLimitHighF1;
else
	TWHighF1=CFHighF*(2^TWFlatInterval);
	if TWHighF1>TWLimitHighF1 TWHighF1=TWLimitHighF1; end;
end
TWHighF2=TWHighF1*(2^TWTransitionInterval);
if TWHighF2>TWLimitHighF2 TWHighF2=TWLimitHighF2; end;
TWHighK1=round(TWHighF1/ml_ls)+1;
TWHighK2=round(TWHighF2/ml_ls)+1;
if TWHighK2>m2_ls TWHighK2=m2_ls; end;
if TWHighK1>m2_ls-1 TWHighK1=m2_ls-1; end;

% TFR Target Frequency Response
k=(1:m_ls);
logweight=[0,log((k+.5)./(k-.5))]';
logmeanLow=sum(LSdB(TWLowK1:TWLowK2).*logweight(TWLowK1:TWLowK2))/sum(logweight(TWLowK1:TWLowK2));
logmeanHigh=sum(LSdB(TWHighK1:TWHighK2).*logweight(TWHighK1:TWHighK2))/sum(logweight(TWHighK1:TWHighK2));
TWLowdB= ones(m2_ls+1,1)*logmeanLow;
TWHighdB=ones(m2_ls+1,1)*logmeanHigh;

TFRdB=frjoin(TWLowdB,LSdB,TWLowK1,TWLowK2);
TFRdB=frjoin(TFRdB,TWHighdB,TWHighK1,TWHighK2);
% dB values untouched, for plotting
TFRMag=dB2mag(TFRdB);
IFRMag=1./TFRMag; % Response inversion
% Normalize response (attenuation only)
% Calculates band limits
BLLowF = CFLowF(1);
if BLLowF==0 BLLowF=TWLimitLowF2; end
BLLowK=round(BLLowF/ml_ls)+1;
BLHighF = CFHighF;
if BLHighF==0 BLHighF=TWLimitHighF1; end
% BLHighK=round(CFHighF/ml_ls)+1;
BLHighK=round(BLHighF/ml_ls)+1;
if BLHighF>mh_ls BLHighF=mh_ls; end;

normfactor=max(IFRMag(BLLowK:BLHighK));
% Normalized equalization filter (attenuation only)
IFRImp = ifft(minphsp(wholespmp(IFRMag)))/normfactor;
IFRImp=semiblackman(m_ls).*IFRImp(1:m_ls);


switch(CFClass)
    case "lp"
		if CFLowAsMP & strcmp (CFLowType{1}, "Butterworth") & (CFLowF(1) > 0)
			CFLowImp = crossButterworthLP(GSFs,m_ls/2,CFLowOrder(1),CFLowF(1),0,0);
			CFHighImp = crossLinear(GSFs,m_ls/2,CFLenghthCycles,0,CFHighF);
			CFImp=postpad(fftconv(CFLowImp,CFHighImp), m_ls); % both already windowed
        elseif (CFHighF > 0 | CFLowF(1) > 0) % Crossover filter
            CFImp = crossLinear(GSFs,m_ls,CFLenghthCycles,CFLowF(1),CFHighF);
        else
            CFImp=delta(m_ls);
            CFClass='mp'; % ???
        end
    case "mp"
		CFLowImp=delta(m_ls);
		for i = 1:length(CFLowF)
			% Highpass
			if CFLowF(i) > 0
				switch(CFLowType{i})
					case "Butterworth"
						CFLowImpTemp = crossButterworth(GSFs,m_ls,CFLowOrder(i),CFLowF(i),0,0);
					case "LinkwitzRiley"
						CFLowImpTemp = crossLinkwitzRiley(GSFs,m_ls,CFLowOrder(i),CFLowF(i),0,0);
				end
			else
				CFLowImpTemp=delta(m_ls);
			end
			CFLowImp=fftconv(CFLowImp,CFLowImpTemp);
		end
		% Lowpass
        if CFHighF > 0
            switch(CFHighType)
                case "Butterworth"
                    CFHighImp = crossButterworth(GSFs,m_ls,0,0,CFHighOrder,CFHighF);
                case "LinkwitzRiley"
                    CFHighImp = crossLinkwitzRiley(GSFs,m_ls,0,0,CFHighOrder,CFHighF);
            end
        else
            CFHighImp=delta(m_ls);
        end
        CFImp=fftconv(CFLowImp,CFHighImp);
		CFImp=semiblackman(m_ls).*CFImp(1:m_ls);
end

%Convolves with loudspeaker correction
CFEqImp=postpad(fftconv(IFRImp,CFImp),m);

% Prepares final response
CFdB=mag2dB(abs(semisp(fft(CFImp))));
IFRdB=mag2dB(abs(semisp(fft(IFRImp))));
CFdB=CFdB+IFRdB;
OUTdB=CFdB+LSdB;

% Saves complete filter
savepcm(CFEqImp, [FSOutDir FSOutPrefix '.pcm']);
# Obsolete function wavwrite
# wavwrite(CFEqImp, GSFs, FSOutWavDepth, [FSOutDir FSOutPrefix '.wav']);
audiowrite([FSOutDir FSOutPrefix '.wav'], CFEqImp, GSFs, 'BitsPerSample', FSOutWavDepth);

%-----------------------------------------------------------------------------------------
% Plotting

% plots magnitude responses

%newplot();
clf();
%figure(1);	
hold on;
% Generates frequecies vector
F_ls=linspace(0,mh_ls,m2_ls+1);

% Defines abscissae range
%PSVTop=max(LSdB); PSVTop=PSVTop+PSVStep*2-mod(PSVTop,PSVStep);
PSVBottom=PSVTop-PSVRange;

axe=gca();

set(axe, "title", FSOutPrefix);
set(axe, "xlabel", "Frequency (KHz)");
set(axe, "ylabel", "Magnitude (dB)");
set(axe, "xlim", [(PSFLow/1000),(PSFHigh/1000)]);
set(axe, "ylim", [PSVBottom,PSVTop]);
set(axe, "xgrid", "on");
set(axe, "ygrid", "on");
set(axe, "xtick", [0.01;0.02;0.03;0.05;0.1;0.2;0.3;0.5;1;2;3;5;10;20]);
set(axe, "xticklabel", ['.01';'.02';'.03';'.05';'.1';'.2';'.3';'.5';'1';'2';'3';'5';'10';'20']);
set(axe, "ytick", (PSVBottom:PSVStep:PSVTop));

% plots original response
semilogx(F_ls/1000,LSdB,strcat("1",";",'Original',";"));
% plots target response
semilogx(F_ls/1000,TFRdB,strcat("2",";",'Target',";"));
% plots CF response
semilogx(F_ls/1000,CFdB,strcat("4",";",'Filter',";"));
% plots final response
semilogx(F_ls/1000,OUTdB,strcat("3",";",'Result',";"));

%% print (strcat(FSOutPrefix,".eps"), "-deps")
print (strcat(FSOutDir,FSOutPrefix,".png"), "-dpng")

%-----------------------------------------------------------------------------------------
% Log
% Indica el tiempo de cálculo
t2=time;
disp ("\n");
disp (strcat ('Calculado en: ' , num2str(t2-t1) , ' s'));
disp ("\n");

% Guarda los factores de normalización
normfactor_dB_str=num2str(-mag2dB(normfactor));
normfile = [FSOutDir FSNormFile];
% unlink(normfile); % Debe hacerse solo una vez para cada fs
fid=fopen(normfile, "a+t");
disp ("\n");

fputs(fid,[FSOutPrefix, "\n"]);
fputs(fid,[normfactor_dB_str, "\n\n"]);
fclose(fid);

endfunction
