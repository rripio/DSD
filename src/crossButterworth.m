%% usage: imp = crossButterworth(fs,m,nl,fl,nh,fh)
%%
%% Gets a n order FIR Butterworth filter.
%%
%% imp = FIR filter Coefficients.
%% Fs  = Sampling frequency.
%% m   = Number of samples.
%% nl  = Order of highpass filter.
%% fl  = Highpass crossover frequency. 0 if only lowpass.
%% nh  = Order of lowpass filter.
%% fh  = Lowpass crossover frequency. 0 if only highpass.

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

function imp=crossButterworth(fs,m,nl,fl,nh,fh);
    
    wl=fl/(fs/2);
    wh=fh/(fs/2);
    imp=delta(m);
    if (fh>0)
        [b,a]=butter(nh,wh);
        imp=filter(b,a,imp);
    end
    
    if (fl>0)
        [b,a]=butter(nl,wl,'high');
        imp=filter(b,a,imp);
    end
    
end
