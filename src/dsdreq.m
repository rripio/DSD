%% This file is part of DSD
%%
%% DSD
%% A GNU-Octave set of scripts for calculating
%% digital loudspeaker crossovers and room correction filters
%% Copyright (C) 2012-2019 Roberto Ripio
%%
%% DSD is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% DSD is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with DSD.  If not, see <https://www.gnu.org/licenses/>.

function dsdreq(fileshort, strGSFs)

home; close all;

disp("RRreq\nRR Room Correction Equalizer\n\
(C) 2011 Roberto Ripio\n");

disp(["Running from " fileparts(cmdpath=mfilename("fullpath")) "\n"]);
configDefaults= [cmdpath ".ini"];
if exist(configDefaults, "file")
    source(configDefaults); % Reads default config
end

filename = [fileshort '.req'];
source(filename); % Reads project config

% admits Fs as a parameter
if exist("strGSFs")
    GSFs=str2num(strGSFs);
else strGSFs = num2str(GSFs);
end

FSOutDir = [FSOutDir "/" strGSFs "/"];
mkdir(FSOutDir);

% MS Message Settings

MSOk = "OK\n"; % End of routine confirmation

% ---------------------------------------------------------------------------------
c0 = 343; %speed of sound
pi2 = 2*pi;

% reads impulse response from file
[dir, name, ext] = fileparts(FSInputFile);
if ext == ".wav"
# Changed obsolete function wavread
    [fullImp, fs] = audioread(FSInputFile);
elseif ext == ".pir"
    [fullImp, fs] = loadpir(FSInputFile);
elseif ext == ".pcm"
    fullImp = loadpcm(FSInputFile);
    fs = FSFs;
elseif ext == ".txt"
    fullimp = load(FSInputFile);
    fs = FSFs;
end
fullImpN = length(fullImp);

m = 2^GSLExp; m2 = m/2;

mLow = fs/m;                        % low freq, freq jump
mHigh = m2*mLow;                    % max freq
ssK = 1:m2;                         % indexes of non aliased frequency vector
ssF = mLow*(ssK-1);                 % non aliased frequency vector
ts = 1/fs;                          % time jump
mT = (1:m)*ts;                      % time vector of impulse samples
mL = mT*c0;                         % distance vector of impulse samples

%% Trims and windows impulse response
[peak,peakK] = max(abs(fullImp));   % finds peak index
preTK = peakK-floor(GSPreT/ts);     % index of impulse window before peak

% Checks if impulse fits the time window
if preTK<1
    preTK = 1;
    warning("Beginning of selected time window is beyond impulse beginning.\n");
end
postTK = fullImpN;

fullImp = fullImp(preTK:postTK);    % trims impulse
fullImpN = length(fullImp);         % impulse length after trim

% Checks if impulse fits the fft size
if fullImpN>m
    fullImpN = m;
    fullImp = fullImp(1:m);
    warning("Impulse length is bigger than fft size. Impulse trimmed.\n");
end
[peak,peakK] = max(abs(fullImp)); % finds new peak index

% Builds window from left to right
window = []; % void window to begin

GSFlatWindowN = abs(GSFlatWindowN+mod(GSFlatWindowN+1,2)); % GSFlatWindowN must be a positive odd
flatK1=peakK-floor(GSFlatWindowN/2); % flat window indexes
flatK2=flatK1 + GSFlatWindowN -1;
windowN = flatK1-1; % length of Pre-peak taper
% Checks if flat top reaches the ends of impulse, then build or omit the tapers
if windowN>0
    window = [window;hanning(windowN*2+1)(1:windowN)]; % Pre-peak taper
else
    GSFlatWindowN += windowN;
    warning("Pre-peak taper window omitted. Check config time window settings and flat top size\n");
end

windowN = fullImpN-flatK2; % length of Post-peak taper
if windowN <= 0
    GSFlatWindowN += windowN;
    buildTaperC = false;
    warning("Post-peak taper window omitted. Check config time window settings and flat top size\n");
else
    buildTaperC=true;
end
if GSFlatWindowN > 0
    window = [window;ones(GSFlatWindowN,1)]; % Flat top
end
if buildTaperC
    window = [window;hanning(windowN*2+1)(windowN+2:windowN*2+1)]; % Post-peak taper
end

fullImp = fullImp.*window;  % windowed impulse
fullImp = postpad(fullImp,m);

disp("Getting magnitude response...");
fullMag = abs(fft(fullImp));
fullMagSs = semisp(fullMag); % semispectrum
disp(MSOk);

% End of impulse shaping and response calculation

%-----------------------------------------------------------------------------
% Smoothing
% ----------------------------------------------------------------------------

% Obtaining pre-smoothed response in log f-space.
logF = logfreq(m,fs,GSSmoothWidthSpl);
mlog = length(logF);
% Pre-smoothing in linear space
fullPreSMagSs=smoothpw(fullMagSs, GSSmoothWidthPre);
% Log sampling of the former
fullPreSMagLog = spline(ssF,fullPreSMagSs(1:m2),logF);
fullPreSMagLogSave = smoothlogpw(fullPreSMagLog,GSSmoothWidthSpl,GSSmoothWidthLow);

% Calculates transition limits
TWHighF1 = TWSchroeder;
TWHighF2=TWHighF1*2^TWIntervalSchroeder;
TWHighK1= find(logF>TWHighF1)(1); %round(TWHighF1/mLow)+1;
TWHighK2= find(logF>TWHighF2)(1); %round(TWHighF2/mLow)+1;
if TWHighK2>mlog TWHighK2=mlog; end;
if TWHighK1>mlog-1 TWHighK1=mlog-1; end;

TWLowF2=TWLimitLowF2;
TWLowF1=TWLowF2/(2^TWFlatInterval);
if TWLowF1<TWLimitLowF1 TWLowF1=TWLimitLowF1; end;
TWLowK2= find(logF>=TWLowF2)(1);
TWLowK1= find(logF>=TWLowF1)(1);
% if TWLowK1<2 TWLowK1=2; end;
% if TWLowK2<3 TWLowK2=3; end;
if TWLowK1<1 TWLowK1=1; end;
if TWLowK2<2 TWLowK2=2; end;

% Base unit response
unitMagLog = ones(mlog,1);

% Target response
EFRefMag = dB2mag(EFRef);
targetMag = EFRefMag * unitMagLog;
flatTargetMag = targetMag;
if TRLowXoF != 0
    [b,a] = butter(TRLowXoOrder, TRLowXoF/(fs/2), 'high');
    crossoverMag = abs(freqz(b, a, logF, fs));
    targetMag .*= crossoverMag;
end
if TRHouseCurve
    [HdB, Hpha] = HouseCurve (logF, TRH_f_corner, TRH_atten, fs);
    targetMag .*= dB2mag(HdB);
end
if TRRoomGain
    [RdB, Rpha] = RoomGain (logF, TRR_gain, fs);
    targetMag .*= dB2mag(RdB);
end
if TRDSS
    [DdB, Dpha] = DSS (logF,fs);
    targetMag .*= dB2mag(DdB);
end

% If only bass eq. wanted, fakes a flat response in highs
if EFBassOnly
    fullPreSMagLog = frjoinlog(fullPreSMagLog,flatTargetMag,TWHighK1,TWHighK2);
end


% Fullrange smoothing
fullSMagLog = smoothlogpw(fullPreSMagLog,GSSmoothWidthSpl,GSSmoothWidthHigh);
% Bassrange smoothing
bassSMagLog = smoothlogpw(fullPreSMagLog,GSSmoothWidthSpl,GSSmoothWidthLow);
bassSMagLog_save = bassSMagLog; % Saves bass smoothing
% Levels the bass response taking full smoothed response as reference
bassSMagLog ./= fullSMagLog;

% Tailor bass response
if TWLimitLowF2 != 0
    bassSMagLog = frjoinlog(unitMagLog,bassSMagLog,TWLowK1,TWLowK2);
end
bassSMagLog = frjoinlog(bassSMagLog,unitMagLog,TWHighK1,TWHighK2);
bassSdBLog = mag2dB(bassSMagLog);
bassPreScaleSMagLog = bassSMagLog; % Save Bass scaling for plotting

%-------------------------------------------------------------------------
% Dip scaling
% Dip identification
kChange=find(diff(bassSdBLog>=EFDipTransition)); % Indexes of sign change in bass magnitude
nChange=length(kChange);
nDips=nChange/2;
kDips=zeros(nDips,2); % Pairs of indexes of first and last index of dips
kDips(:,1)=kChange(mod(1:nChange,2)!=0)(:)+1;
kDips(:,2)=kChange(mod(1:nChange,2)==0)(:);

for i=1:nDips;
    dip=bassSdBLog(kDips(i,1):kDips(i,2));
    ndip=length(dip);
    localMin=min(dip);
    if localMin < EFDipMin
        dipDiff=diff(dip);
        klocalMin=find(dip==localMin);
        eMin=EFDipMin/localMin;
        dip=dip.*(1-((1-eMin)*((dip-EFDipTransition)/\
            (localMin-EFDipTransition)).^EFDipExp));
        bassSdBLog(kDips(i,1):kDips(i,2))=dip;
    end
end

bassSMagLog=dB2mag(bassSdBLog);

% Compose and invert model response
bassSMagLog .*= fullSMagLog; 
filterMagLog = targetMag ./ bassSMagLog;
fiterdBLog = mag2dB(filterMagLog); % saves for plotting

% Filter the original response and correct mode region level changes
% Difference between pre and post filtered smoothed responses are added
% to filter
correctionMagLog = fullPreSMagLog .* filterMagLog;
correctionMagLog = smoothlogpw(correctionMagLog,GSSmoothWidthSpl,GSSmoothWidthHigh);
correctionMagLog = targetMag ./ correctionMagLog;
% Adds correction to previous filter
filterMagLog .*= correctionMagLog;

% Tailor mag at frequency ends
% Calculates high end window (low end already calculated)
TWHighF1 = TWLimitHighF1;
TWHighF2=TWHighF1*2^TWFlatInterval;
if TWHighF2>TWLimitHighF2 TWHighF2=TWLimitHighF2; end;
TWHighK1= find(logF<=TWHighF1)(end); %round(TWHighF1/mLow)+1;
TWHighK2 = find(logF<=TWHighF2)(end);
if TWHighK2>mlog TWHighK2=mlog; end;
if TWHighK1>mlog-1 TWHighK1=mlog-1; end;

% Finds the values of flat eq.
lowLimitMag = mean(filterMagLog(TWLowK1:TWLowK2));
lowLimitMagLog = unitMagLog * lowLimitMag;
highLimitMag = mean(filterMagLog(TWHighK1:TWHighK2));
highLimitMagLog =  unitMagLog * highLimitMag;

filterMagLog = frjoinlog(lowLimitMagLog,filterMagLog,TWLowK1,TWLowK2);
filterMagLog = frjoinlog(filterMagLog, highLimitMagLog,TWHighK1,TWHighK2);

filterMagSs = lininterp (logF, filterMagLog, m, GSFs);
filterImp = semiblackman(m) .* real(ifft(minphsp(wholespmp(filterMagSs))));

%-------------------------------------------------------------------------------
% Output
% [FSDir,FSOutBasename]=fileparts(FSInputFile);
FSOutBasename=fileshort; % Use script name as output name
savepcm(filterImp, [FSOutDir FSOutPrefix FSOutBasename '.pcm']);
# Obsolete function wavwrite
# wavwrite (filterImp, fs, FSOutWavDepth, [FSOutDir FSOutPrefix FSOutBasename ".wav"]);
audiowrite([FSOutDir FSOutPrefix FSOutBasename ".wav"], filterImp, fs, 'BitsPerSample', FSOutWavDepth);

%-------------------------------------------------------------------------------
% Plotting
% plots magnitude responses

%newplot();
clf();
%figure(1); 
hold on;

% Defines abscissae range
%PSVTop=max(mag2dB(bassSMagLog_save)); PSVTop=PSVTop+PSVStep*2-mod(PSVTop,PSVStep);
PSVBottom=PSVTop-PSVRange;

axe=gca();

set(axe, "title", FSOutBasename);
set(axe, "xlabel", "Frequency (KHz)");
set(axe, "ylabel", "Magnitude (dB)");
set(axe, "xlim", [(PSFLow/1000),(PSFHigh/1000)]);
set(axe, "ylim", [PSVBottom,PSVTop]);
set(axe, "xgrid", "on");
set(axe, "ygrid", "on");
set(axe, "xtick", [0.01;0.02;0.03;0.05;0.1;0.2;0.3;0.5;1;2;3;5;10;20]);
set(axe, "xticklabel", ['.01';'.02';'.03';'.05';'.1';'.2';'.3';'.5';'1';'2';'3';'5';'10';'20']);
set(axe, "ytick", (PSVBottom:PSVStep:PSVTop));

plotlogF = logF/1000;

semilogx(plotlogF,mag2dB(filterMagLog),"k;Filter response;","linewidth",2); % Filter
% semilogx(plotlogF,mag2dB(correctionMagLog),"r;Second loop correction"); % Second loop correction
semilogx(plotlogF,mag2dB(fullSMagLog./EFRefMag),"c;High range smoothing;"); % Response: Full range smoothing
semilogx(plotlogF,mag2dB(bassSMagLog_save./EFRefMag),"m;Low range smoothing;"); % Response: Bass smoothing
semilogx(plotlogF,mag2dB(fullPreSMagLogSave.*filterMagLog/EFRefMag),"b;Final response;","linewidth",2); % Final Response: Bass smoothing

print ([FSOutDir FSOutBasename ".png"], "-dpng")

endfunction

